class Announcement < ApplicationRecord
  enum :category, { all_user: 0, course: 1 }, postfix: true

  has_many :announcement_courses
  has_many :courses, through: :announcement_courses

  scope :available, lambda { |user, now = Time.zone.now|
    scoped = where(start_at: ..now, end_at: now..)

    case user.role
    when "instructor"
      scoped.where(category: :all_user)
        .or(
          scoped.where(id:
              scoped.joins(courses: :course_instructors)
                .where({ course_instructors: { user_id: user.id } })
                .select(:id))
        )
    when "student"
      scoped.where(category: :all_user)
        .or(
          scoped.where(id:
              scoped.joins(courses: :course_students)
                .where({ course_students: { user_id: user.id } })
                .select(:id))
        )
    when "admin"
      scoped
    else
      rails NotImplementedError
    end
  }
end
