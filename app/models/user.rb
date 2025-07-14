class User < ApplicationRecord
  has_secure_password

  enum :role, { admin: 1, instructor: 2, student: 3 }

  validates :email, uniqueness: true

  def generate_token(secret_key:, expiration:)
    payload = { pid: pid, exp: expiration }
    JWT.encode(payload, secret_key, "HS256")
  end

  def self.find_by_token(token:, secret_key:)
    decoded = JWT.decode(token, secret_key, true, { algorithm: "HS256" })
    find_by_pid!(decoded[0]["pid"])
  end
end
