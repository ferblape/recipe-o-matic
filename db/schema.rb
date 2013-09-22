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

ActiveRecord::Schema.define(version: 20130907184047) do

  create_table "foods", force: true do |t|
    t.string "name"
  end

  create_table "ingredients", force: true do |t|
    t.integer  "recipe_id"
    t.integer  "food_id"
    t.string   "text"
    t.float    "amount"
    t.string   "unit"
    t.integer  "state",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ingredients", ["food_id"], name: "index_ingredients_on_food_id", using: :btree
  add_index "ingredients", ["recipe_id"], name: "index_ingredients_on_recipe_id", using: :btree
  add_index "ingredients", ["state"], name: "index_ingredients_on_state", using: :btree

  create_table "recipes", force: true do |t|
    t.string   "original_url"
    t.text     "text"
    t.integer  "state",        default: 0
    t.string   "images",                   array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recipes", ["state"], name: "index_recipes_on_state", using: :btree

end
