# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_05_18_103509) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "author_id", null: false
    t.index ["author_id"], name: "index_courses_on_author_id"
  end

  create_table "learning_paths", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lp_courses", force: :cascade do |t|
    t.bigint "learning_path_id", null: false
    t.bigint "course_id", null: false
    t.integer "course_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_lp_courses_on_course_id"
    t.index ["learning_path_id"], name: "index_lp_courses_on_learning_path_id"
  end

  create_table "study_lps", force: :cascade do |t|
    t.bigint "talent_id", null: false
    t.bigint "learning_path_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["learning_path_id"], name: "index_study_lps_on_learning_path_id"
    t.index ["talent_id"], name: "index_study_lps_on_talent_id"
  end

  create_table "study_units", force: :cascade do |t|
    t.boolean "is_course_completed", default: false
    t.bigint "talent_id", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_study_units_on_course_id"
    t.index ["talent_id"], name: "index_study_units_on_talent_id"
  end

  create_table "talents", force: :cascade do |t|
    t.string "name"
    t.boolean "is_author", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "courses", "authors"
  add_foreign_key "lp_courses", "courses"
  add_foreign_key "lp_courses", "learning_paths"
  add_foreign_key "study_lps", "learning_paths"
  add_foreign_key "study_lps", "talents"
  add_foreign_key "study_units", "courses"
  add_foreign_key "study_units", "talents"
end
