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

ActiveRecord::Schema[7.0].define(version: 2023_01_16_141429) do
  create_table "contacts", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "email_addresses", force: :cascade do |t|
    t.integer "contact_id", null: false
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "bounced", default: false
    t.index ["contact_id"], name: "index_email_addresses_on_contact_id"
  end

  add_foreign_key "email_addresses", "contacts"
end
