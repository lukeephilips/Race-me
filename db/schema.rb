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

ActiveRecord::Schema.define(version: 20170228221650) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "goals", force: :cascade do |t|
    t.string   "start_location"
    t.string   "end_location"
    t.string   "name"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.float    "total_distance", default: 0.0
  end

  create_table "races", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "goal_id"
    t.string   "name"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.float    "progress",   default: 0.0
  end

  create_table "runs", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "start_location"
    t.string   "end_location"
    t.string   "travel_method"
    t.integer  "goal_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.float    "total_distance", default: 0.0
    t.float    "start_latlng",   default: [],               array: true
    t.float    "end_latlng",     default: [],               array: true
    t.integer  "total_time",     default: 0
    t.integer  "strava_id",      default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["provider"], name: "index_users_on_provider", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["uid"], name: "index_users_on_uid", using: :btree
  end

end
