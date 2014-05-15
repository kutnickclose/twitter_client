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

ActiveRecord::Schema.define(version: 20140515004908) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "common_pair_followings", force: true do |t|
    t.integer  "pair_id",                null: false
    t.string   "screen_name",            null: false
    t.integer  "following_id", limit: 8, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "common_pair_followings", ["following_id"], name: "index_common_pair_followings_on_following_id", using: :btree

  create_table "pairs", force: true do |t|
    t.string   "first_screen_name",  null: false
    t.string   "second_screen_name", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tweets", force: true do |t|
    t.string   "text",                       null: false
    t.string   "screen_name",                null: false
    t.integer  "tweet_id",         limit: 8, null: false
    t.datetime "tweet_created_at",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "screen_name", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
