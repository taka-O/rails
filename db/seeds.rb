# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create Admin
admin = User.find_by(role_id: role.id)
if admin.blank?
  User.create!(pid: SecureRandom.uuid, email: "admin@example.co.jp", password_digest: BCrypt::Password.create('Passw0rd'), name: "admin", role: :admin)
end
