# Preview all emails at http://localhost:3000/rails/mailers/user_mailer_mailer
class UserMailerPreview < ActionMailer::Preview
  user = create(:user)
  token = user.generate_token_for(:password_reset)
  UserMailer.reset_password(user: user, token:, reset_url: 'http://test/reset_password')
end
