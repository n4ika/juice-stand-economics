class AddRareEventCountToEconomy < ActiveRecord::Migration[7.1]
  def change
    add_column :economies, :rare_event_count, :integer, default: 0
  end
end
