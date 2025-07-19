class AddHappyHourMarkToEconomy < ActiveRecord::Migration[7.1]
  def change
    add_column :economies, :happy_hour_mark_at, :datetime
  end
end
