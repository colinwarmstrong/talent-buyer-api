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

ActiveRecord::Schema.define(version: 2018_10_23_210641) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.string "genre"
    t.integer "songkick_id"
  end

  create_table "buyers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.bigint "venues_id"
    t.string "email"
    t.integer "phone"
    t.index ["venues_id"], name: "index_buyers_on_venues_id"
  end

  create_table "offers", force: :cascade do |t|
    t.integer "status"
    t.bigint "show_id"
    t.bigint "artists_id"
    t.integer "guarantee"
    t.text "bonuses"
    t.text "radius_clause"
    t.integer "total_expenses"
    t.integer "gross_potential"
    t.text "door_times"
    t.string "age_range"
    t.text "merch_split"
    t.index ["artists_id"], name: "index_offers_on_artists_id"
    t.index ["show_id"], name: "index_offers_on_show_id"
  end

  create_table "shows", force: :cascade do |t|
    t.bigint "venues_id"
    t.date "date"
    t.integer "show_status", default: 0
    t.index ["venues_id"], name: "index_shows_on_venues_id"
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.text "street_address"
    t.string "city"
    t.string "state"
    t.integer "zip"
    t.integer "capacity"
  end

  add_foreign_key "buyers", "venues", column: "venues_id"
  add_foreign_key "offers", "artists", column: "artists_id"
  add_foreign_key "offers", "shows"
  add_foreign_key "shows", "venues", column: "venues_id"
end
