class CreateCourseStudents < ActiveRecord::Migration[8.0]
  def change
    create_table :course_students do |t|
      t.references :course, null: false, foreign_key: false, index: true
      t.references :user, null: false, foreign_key: false, index: true
      t.timestamps
    end
  end
end
