class CreateJuices < ActiveRecord::Migration[7.1]
  def change
    create_table :juices do |t|
      t.string :flavor
      t.decimal :price, precision: 8, scale: 2
      t.integer :popularity

      t.timestamps
    end
  end
end
