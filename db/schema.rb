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

ActiveRecord::Schema[7.0].define(version: 2022_08_31_104905) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "mission_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mission_id"], name: "index_bookings_on_mission_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mission_tags", force: :cascade do |t|
    t.bigint "mission_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mission_id"], name: "index_mission_tags_on_mission_id"
    t.index ["tag_id"], name: "index_mission_tags_on_tag_id"
  end

  create_table "missions", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "address"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "img"
    t.string "departure_date"
    t.string "duration"
    t.string "experience_title1"
    t.string "experience_title2"
    t.string "experience_title3"
    t.text "experience_detail1"
    t.text "experience_detail2"
    t.text "experience_detail3"
    t.string "experience_img1"
    t.string "experience_img2"
    t.string "experience_img3"
    t.string "jour_par_jour_img"
    t.text "jour_par_jour_text"
    t.string "impact_local_img"
    t.text "impact_local_text"
    t.string "infos_voyage_title1"
    t.string "infos_voyage_title2"
    t.string "infos_voyage_title3"
    t.string "infos_voyage_title4"
    t.text "infos_voyage_text1"
    t.text "infos_voyage_text2"
    t.text "infos_voyage_text3"
    t.text "infos_voyage_text4"
    t.float "latitude"
    t.float "longitude"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "content"
    t.bigint "booking_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_reviews_on_booking_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_tags_on_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "phone_number"
    t.string "address"
    t.integer "max_budget"
    t.boolean "single_traveler", default: false
    t.bigint "category_id"
    t.index ["category_id"], name: "index_users_on_category_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bookings", "missions"
  add_foreign_key "bookings", "users"
  add_foreign_key "mission_tags", "missions"
  add_foreign_key "mission_tags", "tags"
  add_foreign_key "reviews", "bookings"
  add_foreign_key "tags", "categories"
  add_foreign_key "users", "categories"
end
