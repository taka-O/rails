class CreateCourseUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :course_users do |t|
      t.references :course, null: false, foreign_key: false, index: true
      t.references :user, null: false, foreign_key: false, index: false
      t.string :user_type, null: false

      t.timestamps

      t.index %i[user_type user_id]
    end
  end
end
