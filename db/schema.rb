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

ActiveRecord::Schema[8.0].define(version: 2025_07_01_002608) do
  create_table "announcements", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.string "subject", limit: 128, null: false
    t.string "content", limit: 4096, null: false
    t.integer "mail_flag", limit: 1, null: false
    t.integer "announcement_cd", null: false
    t.datetime "effective_date"
    t.string "effective_memo", limit: 128
    t.string "insert_memo", limit: 128
    t.integer "insert_user_id"
    t.string "update_memo", limit: 128
    t.integer "update_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_announcements_on_course_id"
  end

  create_table "courses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "course_cd", limit: 128, null: false
    t.string "course_name", limit: 64, null: false
    t.text "overview"
    t.integer "school_year", null: false
    t.integer "season_cd", null: false
    t.integer "day_cd", null: false
    t.integer "hour_cd", null: false
    t.string "instructor_name", limit: 128
    t.string "major", limit: 64
    t.integer "class_session_count", default: 15, null: false
    t.integer "indirect_use_flag", limit: 1, default: 0, null: false
    t.bigint "parent_course_id"
    t.integer "group_folder_count", default: 0, null: false
    t.integer "term_flag", limit: 1, default: 0, null: false
    t.string "open_course_pass", limit: 64
    t.integer "open_course_flag", limit: 1, default: 0, null: false
    t.integer "bbs_cd"
    t.integer "chat_cd"
    t.integer "announcement_cd"
    t.integer "faq_cd"
    t.integer "open_course_bbs_flag", limit: 1, default: 0, null: false
    t.integer "open_course_chat_flag", limit: 1, default: 0, null: false
    t.integer "open_course_announcement_flag", limit: 1, default: 0, null: false
    t.integer "open_course_faq_flag", limit: 1, default: 0, null: false
    t.string "attendance_ip_list", limit: 256
    t.integer "courseware_flag", limit: 1, default: 0, null: false
    t.string "courseware_rank", limit: 64, default: "0"
    t.integer "season_cd1"
    t.integer "day_cd1"
    t.integer "hour_cd1"
    t.integer "season_cd2"
    t.integer "day_cd2"
    t.integer "hour_cd2"
    t.integer "season_cd3"
    t.integer "day_cd3"
    t.integer "hour_cd3"
    t.integer "season_cd4"
    t.integer "day_cd4"
    t.integer "hour_cd4"
    t.integer "unread_assignment_display_cd", default: 0, null: false
    t.integer "unread_faq_display_cd", default: 0, null: false
    t.datetime "effective_date"
    t.string "effective_memo", limit: 128
    t.string "insert_memo", limit: 128
    t.integer "insert_user_id"
    t.string "update_memo", limit: 128
    t.integer "update_user_id"
    t.datetime "deleted_at"
    t.string "delete_memo", limit: 128
    t.integer "delete_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_cd", "school_year", "season_cd"], name: "index_courses_on_course_cd_and_school_year_and_season_cd"
    t.index ["course_cd"], name: "index_courses_on_course_cd"
    t.index ["day_cd"], name: "index_courses_on_day_cd"
    t.index ["hour_cd"], name: "index_courses_on_hour_cd"
    t.index ["parent_course_id"], name: "index_courses_on_parent_course_id"
    t.index ["school_year"], name: "index_courses_on_school_year"
    t.index ["season_cd"], name: "index_courses_on_season_cd"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "pid", limit: 64, null: false, comment: "UUID"
    t.string "email", limit: 256, null: false, comment: "メールアドレス"
    t.string "password_digest", comment: "暗号化パスワード"
    t.string "name", null: false, comment: "名前"
    t.string "rest_password_token", comment: "パスワードリセットトークン"
    t.string "rest_password_sent_at", comment: "パスワードリセットトークン送信日時"
    t.string "email_verification_token", comment: "メール確認トークン"
    t.string "email_verification_token_sent_at", comment: "メール確認トークン送信日時"
    t.string "email_verification_at", comment: "メール確認日時"
    t.integer "role", null: false, comment: "ロール", unsigned: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["pid"], name: "index_users_on_pid", unique: true
    t.index ["role"], name: "index_users_on_role"
  end
end
