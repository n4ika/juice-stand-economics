class Economy < ApplicationRecord
  attribute :chaos_index, :integer, default: 0
  attribute :inflation,   :decimal, default: 0.0
  after_initialize :set_defaults

  def set_defaults
    self.rare_event_count ||= 0
  end

  # ------------------------------------------------------------------
  # CHAOS / INFLATION
  # ------------------------------------------------------------------

  # Increment chaos, but freeze it during Happy Hour
  def self.bump_chaos!(by = 1)
    return if HappyHour.active?           # 🔒 freeze chaos during Happy Hour
    first_or_create.increment!(:chaos_index, by)
  end

  # Increment inflation by a percent (e.g. 0.02 for 2 %)
  def self.bump_inflation!(percent = 0.01)
    record = first_or_create
    record.increment!(:inflation, percent)
  end

  # Composite helper used by JuicesController
  def self.apply_sale!(chaos: 1, inflation: 0.02)
    bump_chaos!(chaos)
    bump_inflation!(inflation)
  end

  # ------------------------------------------------------------------
  # QUERY HELPERS
  # ------------------------------------------------------------------
  def chaos_status
    case chaos_index
    when   0..20 then   "🟢 Calm"
    when   20..68  then "🟠 Unstable"
    else                "🔴 Apocalyptic"
    end
  end

  def apocalypse?
    chaos_index > 100
  end

  # ------------------------------------------------------------------
  # RESETTERS
  # ------------------------------------------------------------------
  def self.reset_chaos!      = first_or_create.update!(chaos_index: 0)
  def self.reset_inflation!  = first_or_create.update!(inflation: 0.0)

  def self.reset_all!
    first_or_create.update!(
      chaos_index: 0, inflation: 0.0, rare_event_count: 0
    )
  end

  # ------------------------------------------------------------------
  # MISC. UTILITIES
  # ------------------------------------------------------------------
  def self.report
    econ = first_or_create
    { chaos_index: econ.chaos_index,
      inflation:   econ.inflation.to_f,
      status:      econ.chaos_status }
  end

  # Price / scarcity helpers
  def self.inflate!(delta)
    first_or_create.increment!(:inflation, delta)
  end

  def self.global_price_bump!(percent)
    multiplier = 1.0 + percent
    Juice.update_all("price = ROUND(price * #{multiplier}, 2)")
  end
end
