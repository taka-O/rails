class Course < ApplicationRecord
  has_many :course_instructors, lambda { where(user_type: :instructor) }, class_name: "CourseUser"
  has_many :instructors, through: :course_instructors, source: :user
  has_many :course_students, lambda { where(user_type: :student) }, class_name: "CourseUser"
  has_many :students, through: :course_students, source: :user

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
