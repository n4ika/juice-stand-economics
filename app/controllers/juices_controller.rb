class JuicesController < ApplicationController
  before_action :set_juice, only: %i[show edit update destroy sell]
  def index
    @juices = Juice.all
    @economy = Economy.first_or_create
  end

  def show
  end

  def new
    @juice = Juice.new
  end

  def create
    @juice = Juice.new(juice_params)
    if @juice.save
      redirect_to @juice, notice: "Juice successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @juice.update(juice_params)
      redirect_to @juice, notice: "Juice successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @juice.destroy
    redirect_to juices_path, notice: "Juice deleted."
  end

  def sell
    if @juice.locked?
      remaining = ((@juice.locked_until - Time.current).ceil)
      return redirect_back fallback_location: root_path,
        alert: "#{@juice.flavor} is under audit—try again in #{remaining}s!"
    end

    return redirect_back fallback_location: root_path,
                     alert: "#{@juice.flavor} is unavailable due to scarcity!" \
                   if @juice.scarcity_level >= ScarcityEngine::CRITICAL

    # --- Determine consequence and classify event type ---
    event_type, consequence, chaos_delta, infl_delta = RandomConsequence.pick

    # cancel chaos bump during happy hour
    if HappyHour.active?
      chaos_delta = 0
      infl_delta = -0.01
    end
    
    # ——— audit event branch ———
    if event_type == :audit
      # freeze this juice for 30s
      @juice.update!(locked_until: 30.seconds.from_now)
      # spike chaos anyhow
      Economy.bump_chaos!(chaos_delta)
      flash.now[:alert] = "🚨🏛️ Government audit on #{@juice.flavor}! Sales paused 30 s."
      # re‑render via Turbo
      prepare_dashboard_streams
      return
    end

    # --- Spawn a complaining customer ---
    @customer = RandomCustomer.create!

    # --- Record the sale ---
    @transaction = @juice.transactions.create!(
      consequence: consequence,
      customer: @customer
    )

    # --- Bump popularity ---
    @juice.increment!(:popularity)

    # --- Happy Hour? ------------------------------------------------------
    if HappyHour.active? && HappyHour.eligible?(@economy)
      HappyHour.apply!(@economy)
      flash.now[:notice] = "🎉 Happy Hour! Prices dropped 10 % & inflation eased by 2 %."
    end

    # --- Apply economuc effects based on event type ---
    Economy.apply_sale!(chaos: chaos_delta, inflation: infl_delta)

    # --- Scarcity Tick & Economic Ripple ---
    scarcity_event, affected_juice = ScarcityEngine.tick!(@juice)

    case scarcity_event
    when :spike
      Economy.inflate!(0.08)
      Economy.global_price_bump!(0.27)

      MarketEvent.create!(
        event_type:       :scarcity_spike,
        description:      "#{affected_juice.flavor} became scarce — prices +27 %, inflation +8 %",
        chaos_delta:      chaos_delta + 3,
        inflation_delta:  0.03,
        price_delta_pct:  0.10,
        affected_juice:   affected_juice
      )

      flash.now[:alert] =
        "⚠️  #{affected_juice.flavor} is now scarce! Prices +27 %, inflation +8 %."

    when :recovery
      Economy.inflate!(-0.08)
      Economy.global_price_bump!(-0.27)

      MarketEvent.create!(
        event_type:       :scarcity_recover,
        description:      "#{affected_juice.flavor} supply restored — economy stabilises",
        chaos_delta:      chaos_delta,
        inflation_delta: -0.08,
        price_delta_pct: -0.27,
        affected_juice:   affected_juice
      )

      flash.now[:notice] =
        "✅  #{affected_juice.flavor} scarcity resolved. Prices normalize."
    end

    # --- Track rare events ---
    @economy = Economy.first_or_create!
    @economy.increment!(:rare_event_count) if event_type != :normal

    # --- Flash message ---
    unless scarcity_event
      flash.now[:notice] = "Sold #{@juice.flavor}! #{consequence}"
    end

    @recent_transactions = Transaction.order(created_at: :desc)
    @recent_customers = Customer.order(created_at: :desc)
    @juices = Juice.order(created_at: :desc)

    
    # --- Respond ---
    respond_to do |format|
      format.turbo_stream
      format.html do
        redirect_back fallback_location: root_path,
                      notice: "Sold #{@juice.flavor}! #{@transaction.consequence}"
      end
    end
  end

  private
  
  def set_juice
    @juice = Juice.find(params[:id])
  end

  def juice_params
    params.require(:juice).permit(:flavor, :price, :popularity)
  end
end

