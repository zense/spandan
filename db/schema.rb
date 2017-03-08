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

ActiveRecord::Schema.define(version: 20170308141247) do

  create_table "events", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.text     "description",       limit: 65535
    t.text     "rules",             limit: 65535
    t.integer  "minimum_team_size", limit: 4
    t.integer  "maximum_team_size", limit: 4
    t.text     "contact_details",   limit: 65535
    t.date     "last_date"
    t.integer  "event_type",        limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "icon_file_name",    limit: 255
    t.string   "icon_content_type", limit: 255
    t.integer  "icon_file_size",    limit: 4
    t.datetime "icon_updated_at"
    t.boolean  "visible"
    t.integer  "vol_req",           limit: 4
  end

  create_table "events_volunteers", id: false, force: :cascade do |t|
    t.integer "event_id",     limit: 4
    t.integer "volunteer_id", limit: 4
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "message",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "registrations", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "team_id",    limit: 4
    t.integer  "event_id",   limit: 4,                null: false
    t.boolean  "isvalid",              default: true
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.string   "party1",      limit: 255
    t.string   "party2",      limit: 255
    t.integer  "event_id",    limit: 4
    t.string   "schedule",    limit: 255
    t.string   "description", limit: 255
    t.string   "result",      limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "teams", force: :cascade do |t|
    t.integer  "parent_id",  limit: 4,   null: false
    t.integer  "event_id",   limit: 4
    t.string   "name",       limit: 255
    t.boolean  "isvalid"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "teams_users", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "team_id",    limit: 4
    t.integer  "event_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255,                 null: false
    t.string   "roll_no",                limit: 255,                 null: false
    t.boolean  "volunteer",                          default: false
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.string   "user_type",              limit: 255, default: ""
    t.string   "year_of_joining",        limit: 255, default: ""
    t.string   "student_type",           limit: 255, default: ""
    t.boolean  "spoc",                               default: false
    t.integer  "spoc_event_id",          limit: 4,   default: 0
    t.integer  "volunteer_event_id",     limit: 4,   default: 0
    t.string   "phone_number",           limit: 255, default: ""
    t.integer  "tshirt_size",            limit: 2
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "volunteer_requests", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "priority1",   limit: 4
    t.integer  "priority2",   limit: 4
    t.integer  "priority3",   limit: 4
    t.boolean  "approved",              default: false
    t.integer  "event_id",    limit: 4, default: 0
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.datetime "approved_on"
    t.integer  "approved_by", limit: 4
    t.integer  "priority4",   limit: 4
    t.integer  "tshirt_size", limit: 2
  end

  create_table "volunteers", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "email",       limit: 255
    t.string   "roll",        limit: 255
    t.integer  "tshirt_size", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

end
