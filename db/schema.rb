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

ActiveRecord::Schema.define(version: 2023_03_27_015215) do

  create_table "ca_articles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.text "body_1", null: false
    t.text "body_2", null: false
    t.text "body_3", null: false
    t.datetime "released_at", null: false
    t.datetime "expired_at"
    t.boolean "club_advisor_only", default: false, null: false
    t.string "status", default: "draft", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "club_advisor_id", null: false
    t.index ["club_advisor_id"], name: "index_ca_articles_on_club_advisor_id"
  end

  create_table "club_advisors", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", null: false
    t.string "family_name", null: false
    t.string "given_name", null: false
    t.string "family_name_kana", null: false
    t.string "given_name_kana", null: false
    t.string "career"
    t.string "hashed_password"
    t.date "start_date", null: false
    t.date "end_date"
    t.boolean "suspended", default: false, null: false
    t.bigint "sport_id"
    t.bigint "area_id"
    t.bigint "school_id"
    t.bigint "club_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "birthday"
    t.integer "sex", default: 1, null: false
    t.index ["area_id"], name: "index_club_advisors_on_area_id"
    t.index ["club_id"], name: "index_club_advisors_on_club_id"
    t.index ["school_id"], name: "index_club_advisors_on_school_id"
    t.index ["sport_id"], name: "index_club_advisors_on_sport_id"
  end

  create_table "ec_articles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title", null: false
    t.text "body_1", null: false
    t.text "body_2", null: false
    t.text "body_3", null: false
    t.datetime "released_at", null: false
    t.datetime "expired_at"
    t.boolean "external_coach_only", default: false, null: false #削除予定
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "external_coach_id", null: false
    t.string "status", default: "draft", null: false
    t.index ["external_coach_id"], name: "index_ec_articles_on_external_coach_id"
  end

  create_table "external_coaches", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", null: false
    t.string "family_name", null: false
    t.string "given_name", null: false
    t.string "family_name_kana", null: false
    t.string "given_name_kana", null: false
    t.string "hashed_password"
    t.date "start_date", null: false
    t.date "end_date"
    t.boolean "suspended", default: false, null: false
    t.bigint "sport_id", null: false
    t.bigint "area_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "birthday"
    t.integer "sex", default: 1, null: false
    t.index ["area_id"], name: "index_external_coaches_on_area_id"
    t.index ["family_name_kana", "given_name_kana"], name: "index_external_coaches_on_family_name_kana_and_given_name_kana"
    t.index ["sport_id"], name: "index_external_coaches_on_sport_id"
  end

  add_foreign_key "ec_articles", "external_coaches"
end
