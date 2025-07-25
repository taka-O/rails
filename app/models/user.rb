class User < ApplicationRecord
  has_secure_password

  generates_token_for :password_reset, expires_in: 24.hours do
    password_salt&.last(10)
  end

  has_many :course_instructors, foreign_key: :user_id
  has_many :charged_courses, through: :course_instructors
  has_many :course_students, foreign_key: :user_id
  has_many :belonging_courses, through: :course_students

  enum :role, { admin: 1, instructor: 2, student: 3 }

  validates :email, uniqueness: true

  SECRET_KEY = Rails.application.credentials.secret_key_base

  def generate_token(expiration:)
    payload = { pid: pid, exp: expiration }
    JWT.encode(payload, SECRET_KEY, "HS256")
  end

  def self.find_by_token(token:)
    decoded = JWT.decode(token, SECRET_KEY, true, { algorithm: "HS256" })
    find_by_pid!(decoded[0]["pid"])
  end
end
