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

ActiveRecord::Schema[8.0].define(version: 2025_02_16_124519) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "drivers", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_drivers_on_email", unique: true
    t.index ["phone"], name: "index_drivers_on_phone", unique: true
  end

  create_table "mitra_admin_assignments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "mitra_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mitra_id"], name: "index_mitra_admin_assignments_on_mitra_id"
    t.index ["user_id", "mitra_id"], name: "index_mitra_admin_assignments_on_user_id_and_mitra_id", unique: true
    t.index ["user_id"], name: "index_mitra_admin_assignments_on_user_id"
  end

  create_table "mitra_drivers", force: :cascade do |t|
    t.bigint "driver_id", null: false
    t.bigint "mitra_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["driver_id", "mitra_id"], name: "index_mitra_drivers_on_driver_id_and_mitra_id", unique: true
    t.index ["driver_id"], name: "index_mitra_drivers_on_driver_id"
    t.index ["mitra_id"], name: "index_mitra_drivers_on_mitra_id"
  end

  create_table "mitras", force: :cascade do |t|
    t.string "business_name"
    t.text "business_address"
    t.string "contact_person_name"
    t.string "contact_person_phone"
    t.string "email"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_mitras_on_email", unique: true
  end

  create_table "service_instances", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "pricing_details"
    t.jsonb "service_area"
    t.integer "status"
    t.bigint "service_template_id", null: false
    t.bigint "mitra_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mitra_id"], name: "index_service_instances_on_mitra_id"
    t.index ["service_template_id"], name: "index_service_instances_on_service_template_id"
  end

  create_table "service_templates", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.jsonb "pricing_schema"
    t.jsonb "service_area_schema"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "role"
    t.jsonb "profile_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "mitra_admin_assignments", "mitras"
  add_foreign_key "mitra_admin_assignments", "users"
  add_foreign_key "mitra_drivers", "drivers"
  add_foreign_key "mitra_drivers", "mitras"
  add_foreign_key "service_instances", "mitras"
  add_foreign_key "service_instances", "service_templates"
end
