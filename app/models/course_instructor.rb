class CourseInstructor < ApplicationRecord
  belongs_to :course
  belongs_to :instructor, foreign_key: :user_id, class_name: "User"
end
