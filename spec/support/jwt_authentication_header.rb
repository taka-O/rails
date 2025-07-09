RSpec.shared_context 'jwt authentication header' do
  let(:jwt_headers) { { CONTENT_TYPE: 'application/json', Authorization: authorization } }
  let(:user) { create(:user, email: 'test@test.com', password_digest: BCrypt::Password.create('hogehoge')) }
  let(:token) do
    secret_key = Rails.application.credentials.secret_key_base
    user.generate_jwt(secret_key: secret_key, expiration: Time.zone.now.since(7.days).to_i)
  end
  let(:authorization) { "Bearer: #{token}" }
end
