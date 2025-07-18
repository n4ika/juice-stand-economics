class AddScarcityLevelToJuices < ActiveRecord::Migration[7.1]
  def change
    add_column :juices, :scarcity_level, :integer
  end
end
