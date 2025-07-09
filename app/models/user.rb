class User < ApplicationRecord
  has_secure_password

  enum :role, { admin: 1, instructor: 2, student: 3 }

  validates :email, uniqueness: true

  def generate_jwt(secret_key:, expiration:)
    payload = { pid: pid, exp: expiration }
    JWT.encode(payload, secret_key)
  end
end
