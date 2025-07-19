class ScarcityEngine
  CRITICAL = 50       # at or above → “out of stock”
  MAX      = 100
  MIN      = 0

  # Only ~5 % of sales even touch scarcity
  SCARCITY_TICK_PROB = 0.10

  # Bump tables
  RISE  = [1, 1, 2, 3, 5]             # gentle upward pressure
  FALL  = [-1, -2, -3, -5]            # gentle recovery
  SPIKE = 25..40                      # sudden shortage burst
  DIP   = -40..-25                    # sudden supply windfall

  # Returns [:spike|:recovery|nil, juice]
  def self.tick!(juice)
    return [nil, juice] unless rand < SCARCITY_TICK_PROB

    change =
      if juice.scarcity_level >= CRITICAL && rand < 0.30
        FALL.sample                # when scarce, more likely to fall/recover
      elsif juice.scarcity_level.zero? && rand < 0.05
        SPIKE.to_a.sample          # rare big spike from plenty
      elsif juice.scarcity_level >= CRITICAL
        FALL.sample
      elsif juice.scarcity_level > 0 && rand < 0.02
        DIP.to_a.sample            # rare windfall drops scarcity fast
      else
        RISE.sample                # normal upward drift
      end

    new_level = (juice.scarcity_level + change).clamp(MIN, MAX)

    event =
      if  juice.scarcity_level <  CRITICAL && new_level >= CRITICAL
        :spike      # crossed into scarcity
      elsif juice.scarcity_level >= CRITICAL && new_level <  CRITICAL
        :recovery   # scarcity cleared
      end

    juice.update!(scarcity_level: new_level)
    [event, juice]
  end
end
