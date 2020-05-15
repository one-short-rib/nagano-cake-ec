# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_14_093456) do

  create_table "items", force: :cascade do |t|
    t.integer "genre_id", null: false
    t.string "name", null: false
    t.string "explanation", null: false
    t.integer "price", null: false
    t.boolean "is_saled", default: true
    t.string "item_image_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_items_on_genre_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "order_status", default: 0
    t.string "postal_code", null: false
    t.string "address", null: false
    t.string "name", null: false
    t.integer "postage", default: 800
    t.integer "payment_method", default: 0
    t.integer "billing_amount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_orders_on_member_id"
  end

end
