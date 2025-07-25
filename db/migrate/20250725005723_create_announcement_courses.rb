class CreateAnnouncementCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :announcement_courses do |t|
      t.references :announcement, null: false, foreign_key: false, index: true
      t.references :course, null: false, foreign_key: false, index: true
      t.timestamps
    end
  end
end
