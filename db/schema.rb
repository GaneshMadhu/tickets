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

ActiveRecord::Schema.define(version: 20170120102002) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tickets", force: :cascade do |t|
    t.text     "created_by"
    t.text     "description"
    t.integer  "severity"
    t.integer  "status"
    t.integer  "cancelled_reason"
    t.text     "cancelled_other_description"
    t.text     "comments"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["severity"], name: "index_tickets_on_severity", using: :btree
    t.index ["status"], name: "index_tickets_on_status", using: :btree
  end

end
