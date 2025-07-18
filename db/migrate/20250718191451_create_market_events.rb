# db/migrate/202507xxxxxx_create_market_events.rb
class CreateMarketEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :market_events do |t|
      t.string  :event_type
      t.text    :description
      t.integer :chaos_delta
      t.decimal :inflation_delta, precision: 5, scale: 2   
      t.decimal :price_delta_pct, precision: 5, scale: 2   
      t.references :affected_juice, foreign_key: { to_table: :juices }

      t.timestamps
    end
  end
end
