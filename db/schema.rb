# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_09_05_131645) do

  create_table "appointments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "slot", null: false
    t.integer "hour", null: false
    t.integer "day", null: false
    t.integer "week", null: false
    t.integer "year", null: false
    t.text "subject"
    t.string "note"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "course_id", default: 0, null: false
    t.string "location"
    t.string "uuid"
    t.index ["course_id"], name: "index_appointments_on_course_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.integer "week"
    t.integer "year"
    t.text "slots"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "course_id", default: 0, null: false
    t.index ["course_id"], name: "index_schedules_on_course_id"
    t.index ["week", "year"], name: "index_schedules_on_week_and_year", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "login"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["login"], name: "index_users_on_login", unique: true
  end

  add_foreign_key "appointments", "courses"
  add_foreign_key "appointments", "users"
  add_foreign_key "schedules", "courses"
end
