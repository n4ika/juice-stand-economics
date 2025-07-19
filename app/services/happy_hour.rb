class HappyHour
  WINDOW = (0...15).freeze
  class << self
    # ── Query helpers ──────────────────────────────────────────────────
    def active?(time = Time.current)
      WINDOW.cover?(time.min)
    end

    # Returns true if we HAVE NOT yet applied discounts in THIS window
    def eligible?(economy = Economy.first_or_create)
      return false unless active?
      last = economy.happy_hour_mark_at
      last.nil? || last < window_start(Time.current)
    end

    # ── Action helper ──────────────────────────────────────────────────
    # Performs the discount + inflation relief exactly once per window.
    def apply!(economy = Economy.first_or_create)
      return unless eligible?(economy)

      # 1. ease inflation
      economy.class.inflate!(-0.02)

      # 2. global price drop 10 %
      economy.class.global_price_bump!(-0.10)

      # 3. remember we ran
      economy.update!(happy_hour_mark_at: Time.current)
    end

    private

    # returns a Time at the *start* of the current window
    def window_start(time)
      time.change(min: WINDOW.begin, sec: 0)
    end
  end
end
