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

ActiveRecord::Schema[7.0].define(version: 2022_11_28_005531) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "alternatives", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "body", null: false
    t.boolean "correct", default: false, null: false
    t.uuid "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "option"
    t.index ["question_id"], name: "index_alternatives_on_question_id"
  end

  create_table "questions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "body", null: false
    t.float "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "test_id", null: false
    t.uuid "user_id", null: false
    t.index ["test_id"], name: "index_questions_on_test_id"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "school_classes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "name"], name: "index_school_classes_on_user_id_and_name", unique: true
    t.index ["user_id"], name: "index_school_classes_on_user_id"
  end

  create_table "students", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "identifier", null: false
    t.uuid "school_class_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id", null: false
    t.index ["identifier"], name: "index_students_on_identifier", unique: true
    t.index ["school_class_id"], name: "index_students_on_school_class_id"
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "test_grade", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "test_id", null: false
    t.uuid "student_id", null: false
    t.integer "grade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_test_grade_on_student_id"
    t.index ["test_id"], name: "index_test_grade_on_test_id"
  end

  create_table "tests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id", null: false
    t.uuid "school_class_id", null: false
    t.string "name", null: false
    t.date "test_date", null: false
    t.index ["school_class_id"], name: "index_tests_on_school_class_id"
    t.index ["user_id", "name"], name: "index_tests_on_user_id_and_name", unique: true
    t.index ["user_id"], name: "index_tests_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "alternatives", "questions"
  add_foreign_key "questions", "tests"
  add_foreign_key "questions", "users"
  add_foreign_key "school_classes", "users"
  add_foreign_key "students", "school_classes"
  add_foreign_key "students", "users"
  add_foreign_key "test_grade", "students"
  add_foreign_key "test_grade", "tests"
  add_foreign_key "tests", "school_classes"
  add_foreign_key "tests", "users"
end
