class CourseStudent < ApplicationRecord
  belongs_to :course
  belongs_to :student, foreign_key: :user_id, class_name: "User"
end
