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

ActiveRecord::Schema.define(version: 20180807022917) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "doctor_pharmacists", force: :cascade do |t|
    t.string   "email",            default: "", null: false
    t.string   "password",         default: "", null: false
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "status",           default: 0
    t.string   "contact_number"
    t.string   "auth_token"
    t.string   "speciality"
    t.string   "hospital_address"
    t.string   "store_address"
    t.integer  "role"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "patients", force: :cascade do |t|
    t.string   "email",          default: "", null: false
    t.string   "password",       default: "", null: false
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "status",         default: 0
    t.string   "contact_number"
    t.string   "auth_token"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "prescription_requests", force: :cascade do |t|
    t.integer  "prescription_id"
    t.integer  "doctor_pharmacist_id"
    t.integer  "status",               default: 0
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "prescription_requests", ["doctor_pharmacist_id"], name: "index_prescription_requests_on_doctor_pharmacist_id", using: :btree
  add_index "prescription_requests", ["prescription_id"], name: "index_prescription_requests_on_prescription_id", using: :btree

  create_table "prescriptions", force: :cascade do |t|
    t.integer  "patient_id"
    t.string   "prescription_details"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "prescriptions", ["patient_id"], name: "index_prescriptions_on_patient_id", using: :btree

end
