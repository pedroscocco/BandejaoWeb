# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140522165508) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "days", force: true do |t|
    t.string   "name"
    t.datetime "datetime"
    t.integer  "menu_id"
  end

  add_index "days", ["menu_id"], name: "index_days_on_menu_id", using: :btree

  create_table "days_dishes", id: false, force: true do |t|
    t.integer "day_id",  null: false
    t.integer "dish_id", null: false
  end

  add_index "days_dishes", ["day_id", "dish_id"], name: "index_days_dishes_on_day_id_and_dish_id", using: :btree

  create_table "dishes", force: true do |t|
    t.string "name"
    t.string "dish_type"
  end

  create_table "menus", force: true do |t|
    t.string   "restaurant"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
