RSpec.shared_context "token authentication header" do
  let(:auth_user) { create(:user, email: "test@test.com", password_digest: BCrypt::Password.create('hogehoge')) }

  def auth_headers(user = nil)
    user ||= auth_user
    token = user.generate_token(expiration: Time.zone.now.since(7.days).to_i)
    { HTTP_ACCEPT: "application/json", Authorization: "Bearer: #{token}" }
  end
end
