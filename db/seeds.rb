# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# for development
if Rails.env.development?
  # Create User
  if User.all.size.zero?
    User.create!(pid: SecureRandom.uuid, email: "admin@example.com", password_digest: BCrypt::Password.create('Passw0rd'), name: "admin", role: :admin)

    instructor1 = User.create!(pid: SecureRandom.uuid, email: "instructor1@example.com", password_digest: BCrypt::Password.create('Passw0rd'), name: "instructor1", role: :instructor)
    instructor2 = User.create!(pid: SecureRandom.uuid, email: "instructor2@example.com", password_digest: BCrypt::Password.create('Passw0rd'), name: "instructor2", role: :instructor)

    student1 = User.create!(pid: SecureRandom.uuid, email: "student1@example.com", password_digest: BCrypt::Password.create('Passw0rd'), name: "student1", role: :student)
    student2 = User.create!(pid: SecureRandom.uuid, email: "student2@example.com", password_digest: BCrypt::Password.create('Passw0rd'), name: "student2", role: :student)
    student3 = User.create!(pid: SecureRandom.uuid, email: "student3@example.com", password_digest: BCrypt::Password.create('Passw0rd'), name: "student3", role: :student)
  end

  # Create Course
  if Course.all.size.zero?
    course1 = Course.create!(name: 'course1', description: "course1 description", start_at: '2025-04-01', end_at: "2025-09-30")
    CourseUser.create!(course_id: course1.id, user_id: instructor1.id, user_type: :instructor)
    CourseUser.create!(course_id: course1.id, user_id: student1.id, user_type: :student)
    CourseUser.create!(course_id: course1.id, user_id: student2.id, user_type: :student)

    course2 = Course.create!(name: 'course2', description: "course2 description", start_at: '2025-04-01', end_at: "2025-09-30")
    CourseUser.create!(course_id: course2.id, user_id: instructor2.id, user_type: :instructor)
    CourseUser.create!(course_id: course2.id, user_id: student2.id, user_type: :student)
    CourseUser.create!(course_id: course2.id, user_id: student3.id, user_type: :student)
  end

  # Create Announcement
  if Announcement.all.size.zero?
    Announcement.create!(title: 'announcement1', content: 'announcement1 content', category: :all_user)

    announcement2 = Announcement.create!(title: 'course announcement1', content: 'course announcement1 content', category: :course)
    AnnouncementCourse.create!(announcement_id: announcement2.id, course_id: course1.id)

    announcement3 = Announcement.create!(title: 'course announcement2', content: 'course announcement2 content', category: :course)
    AnnouncementCourse.create!(announcement_id: announcement3.id, course_id: course2.id)
  end
end
