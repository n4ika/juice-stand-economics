class AddLockedUntilToJuices < ActiveRecord::Migration[7.1]
  def change
    add_column :juices, :locked_until, :datetime
  end
end
