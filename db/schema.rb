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

ActiveRecord::Schema.define(version: 20160113180126) do

  create_table "events", force: :cascade do |t|
    t.string   "Name",              limit: 255
    t.text     "Description",       limit: 65535
    t.text     "Rules",             limit: 65535
    t.integer  "Minimum_team_size", limit: 4
    t.integer  "Maximum_team_size", limit: 4
    t.string   "SPOC_of_the_event", limit: 255
    t.text     "Contact_Details",   limit: 65535
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 255,                 null: false
    t.string   "roll_no",    limit: 255,                 null: false
    t.boolean  "volunteer",              default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

end
