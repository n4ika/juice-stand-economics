class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.references :juice, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.text :consequence

      t.timestamps
    end
  end
end
