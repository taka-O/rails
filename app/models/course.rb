class Course < ApplicationRecord
  has_many :course_instructors
  has_many :instructors, through: :course_instructors, class_name: "User"
  has_many :course_students
  has_many :students, through: :course_students, class_name: "User"

  scope :related, lambda { |user|
    case user.role
    when "instructor"
      joins(:course_instructors)
        .where(course_instructors: { user_id: user.id })
    when "student"
      joins(:course_students)
        .where(course_students: { user_id: user.id })
    when "admin"
      all
    else
      rails NotImplementedError
    end
  }
end
