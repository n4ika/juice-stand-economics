class MarketEvent < ApplicationRecord
  belongs_to :affected_juice,
             class_name: "Juice",
             optional:    true

  enum event_type: {
    scarcity_spike:   "scarcity_spike",
    scarcity_recover: "scarcity_recover",
    rare_consequence: "rare_consequence",
    daily_summary:    "daily_summary"
  }

  def time_label
    created_at.strftime("%H:%M:%S")
  end
end
