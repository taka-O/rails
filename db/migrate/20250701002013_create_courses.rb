class CreateCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :courses do |t|
      t.string :course_cd, limit: 128, null: false
      t.string :course_name, limit: 64, null: false
      t.text :overview
      t.integer :school_year, null: false
      t.integer :season_cd, null: false
      t.integer :day_cd, null: false
      t.integer :hour_cd, null: false
      t.string :instructor_name, limit: 128
      t.string :major, limit: 64
      t.integer :class_session_count, default: 15, null: false
      t.integer :indirect_use_flag, limit: 1, default: 0, null: false
      t.bigint :parent_course_id
      t.integer :group_folder_count, default: 0, null: false
      t.integer :term_flag, limit: 1, default: 0, null: false
      t.string :open_course_pass, limit: 64
      t.integer :open_course_flag, limit: 1, default: 0, null: false
      t.integer :bbs_cd
      t.integer :chat_cd
      t.integer :announcement_cd
      t.integer :faq_cd
      t.integer :open_course_bbs_flag, limit: 1, default: 0, null: false
      t.integer :open_course_chat_flag, limit: 1, default: 0, null: false
      t.integer :open_course_announcement_flag, limit: 1, default: 0, null: false
      t.integer :open_course_faq_flag, limit: 1, default: 0, null: false
      t.string :attendance_ip_list, limit: 256
      t.integer :courseware_flag, limit: 1, default: 0, null: false
      t.string :courseware_rank, limit: 64, default: '0'
      t.integer :season_cd1
      t.integer :day_cd1
      t.integer :hour_cd1
      t.integer :season_cd2
      t.integer :day_cd2
      t.integer :hour_cd2
      t.integer :season_cd3
      t.integer :day_cd3
      t.integer :hour_cd3
      t.integer :season_cd4
      t.integer :day_cd4
      t.integer :hour_cd4
      t.integer :unread_assignment_display_cd, default: 0, null: false
      t.integer :unread_faq_display_cd, default: 0, null: false
      t.datetime :effective_date
      t.string :effective_memo, limit: 128
      t.string :insert_memo, limit: 128
      t.integer :insert_user_id
      t.string :update_memo, limit: 128
      t.integer :update_user_id
      t.datetime :deleted_at
      t.string :delete_memo, limit: 128
      t.integer :delete_user_id
      t.timestamps

      t.index %i[course_cd school_year season_cd]
      t.index %i[course_cd]
      t.index %i[day_cd]
      t.index %i[hour_cd]
      t.index %i[parent_course_id]
      t.index %i[school_year]
      t.index %i[season_cd]
    end
  end
end
