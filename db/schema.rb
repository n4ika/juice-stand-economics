# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_07_18_191451) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "mood"
    t.text "complaint"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "economies", force: :cascade do |t|
    t.integer "chaos_index", default: 0, null: false
    t.decimal "inflation", precision: 5, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rare_event_count", default: 0
  end

  create_table "juices", force: :cascade do |t|
    t.string "flavor"
    t.decimal "price", precision: 8, scale: 2
    t.integer "popularity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "scarcity_level"
  end

  create_table "market_events", force: :cascade do |t|
    t.string "event_type"
    t.text "description"
    t.integer "chaos_delta"
    t.decimal "inflation_delta", precision: 5, scale: 2
    t.decimal "price_delta_pct", precision: 5, scale: 2
    t.bigint "affected_juice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["affected_juice_id"], name: "index_market_events_on_affected_juice_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "juice_id", null: false
    t.bigint "customer_id", null: false
    t.text "consequence"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_transactions_on_customer_id"
    t.index ["juice_id"], name: "index_transactions_on_juice_id"
  end

  add_foreign_key "market_events", "juices", column: "affected_juice_id"
  add_foreign_key "transactions", "customers"
  add_foreign_key "transactions", "juices"
end
