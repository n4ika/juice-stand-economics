# app/models/economy.rb
class Economy < ApplicationRecord
  attribute :chaos_index, :integer, default: 0
  attribute :inflation,   :decimal, default: 0.0
  after_initialize :set_defaults

  def set_defaults
    self.rare_event_count ||= 0
  end

  # Increment chaos by a given amount (default: 1)
  def self.bump_chaos!(by = 1)
    first_or_create.increment!(:chaos_index, by)
  end

  # Increment inflation by a percent (e.g. 0.02 for 2%)
  def self.bump_inflation!(percent = 0.01)
    record = first_or_create
    new_value = record.inflation + percent
    record.update!(inflation: new_value)
  end

  # ——— Composite Actions ———

  # Apply both chaos and inflation effects in one go
  # e.g. Economy.apply_sale!(chaos: 2, inflation: 0.03)
  def self.apply_sale!(chaos: 1, inflation: 0.02)
    bump_chaos!(chaos)
    bump_inflation!(inflation)
  end

  # ——— Query Helpers ———

  # Human‑friendly chaos level
  def chaos_status
    case chaos_index
    when   0..10 then "🟢 Calm"
    when  11..50 then "🟠 Unstable"
    else               "🔴 Apocalyptic"
    end
  end

  # True when things have truly hit the fan
  def apocalypse?
    chaos_index > 100
  end

  # ——— Resetters ———

  # Reset chaos back to zero
  def self.reset_chaos!
    first_or_create.update!(chaos_index: 0)
  end

  # Reset inflation back to 0.0
  def self.reset_inflation!
    first_or_create.update!(inflation: 0.0)
  end

  # Wipe everything and start fresh
  def self.reset_all!
    first_or_create.update!(
      chaos_index: 0,
      inflation: 0.0,
      rare_event_count: 0
    )
  end

  # ——— Reporting ———

  # Return a simple status hash (good for APIs or debugging)
  def self.report
    econ = first_or_create
    {
      chaos_index:  econ.chaos_index,
      inflation:    econ.inflation.to_f,
      status:       econ.chaos_status
    }
  end

  # ——— Juice Scarcity and Inflation ———

  def self.inflate!(delta)
    record = first_or_create
    record.increment!(:inflation, delta)
  end

  def self.global_price_bump!(percent)
    multiplier = 1.0 + percent
    Juice.update_all("price = ROUND(price * #{multiplier}, 2)")
  end
end
