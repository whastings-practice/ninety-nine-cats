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

ActiveRecord::Schema.define(version: 20140521182951) do

  create_table "cat_rental_requests", force: true do |t|
    t.integer  "cat_id",                null: false
    t.date     "start_date",            null: false
    t.date     "end_date",              null: false
    t.string   "status",     limit: 10, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "cat_rental_requests", ["cat_id"], name: "index_cat_rental_requests_on_cat_id"
  add_index "cat_rental_requests", ["user_id"], name: "index_cat_rental_requests_on_user_id"

  create_table "cats", force: true do |t|
    t.string   "name",                                      null: false
    t.integer  "age"
    t.date     "birth_date"
    t.string   "color",              limit: 20
    t.string   "sex",                limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",                       default: 0, null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "cats", ["user_id"], name: "index_cats_on_user_id"

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "sessions", force: true do |t|
    t.string   "token",      null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["token"], name: "index_sessions_on_token", unique: true
  add_index "sessions", ["user_id"], name: "index_sessions_on_user_id"

  create_table "users", force: true do |t|
    t.string   "user_name",       limit: 50, null: false
    t.string   "password_digest", limit: 60, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

end
