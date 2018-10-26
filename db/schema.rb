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

ActiveRecord::Schema.define(version: 2018_10_26_231152) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artist_genres", force: :cascade do |t|
    t.bigint "artist_id"
    t.bigint "genre_id"
    t.index ["artist_id"], name: "index_artist_genres_on_artist_id"
    t.index ["genre_id"], name: "index_artist_genres_on_genre_id"
  end

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.string "agency"
    t.string "image_url"
    t.integer "popularity"
    t.integer "songkick_id"
    t.string "spotify_url"
    t.string "spotify_id"
    t.integer "spotify_followers"
  end

  create_table "buyer_venues", force: :cascade do |t|
    t.bigint "buyer_id"
    t.bigint "venue_id"
    t.index ["buyer_id"], name: "index_buyer_venues_on_buyer_id"
    t.index ["venue_id"], name: "index_buyer_venues_on_venue_id"
  end

  create_table "buyers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_buyers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_buyers_on_reset_password_token", unique: true
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
  end

  create_table "jwt_blacklist", force: :cascade do |t|
    t.string "jti", null: false
    t.index ["jti"], name: "index_jwt_blacklist_on_jti"
  end

  create_table "offers", force: :cascade do |t|
    t.integer "status", default: 0
    t.bigint "show_id"
    t.bigint "artist_id"
    t.integer "guarantee"
    t.text "bonuses"
    t.text "radius_clause"
    t.integer "total_expenses"
    t.integer "gross_potential"
    t.text "door_times"
    t.string "age_range"
    t.text "merch_split"
    t.index ["artist_id"], name: "index_offers_on_artist_id"
    t.index ["show_id"], name: "index_offers_on_show_id"
  end

  create_table "shows", force: :cascade do |t|
    t.bigint "venue_id"
    t.date "date"
    t.integer "show_status", default: 0
    t.index ["venue_id"], name: "index_shows_on_venue_id"
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.text "street_address"
    t.string "city"
    t.string "state"
    t.integer "zip"
    t.integer "capacity"
    t.integer "venue_songkick_id"
  end

  add_foreign_key "artist_genres", "artists"
  add_foreign_key "artist_genres", "genres"
  add_foreign_key "buyer_venues", "buyers"
  add_foreign_key "buyer_venues", "venues"
  add_foreign_key "offers", "artists"
  add_foreign_key "offers", "shows"
  add_foreign_key "shows", "venues"
end
