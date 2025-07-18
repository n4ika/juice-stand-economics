class CreateEconomies < ActiveRecord::Migration[7.1]
  def change
    create_table :economies do |t|
      t.integer :chaos_index, default: 0,   null: false
      t.decimal :inflation,   precision: 5, scale: 2, default: 0.0, null: false

      t.timestamps
    end
  end
end
