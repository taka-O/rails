class UserMailer < ApplicationMailer
  def reset_password(user:, token:, reset_url:)
    @user = user
    @token = token
    @url = reset_url
    mail(to: @user.email, subject: "パスワード再設定")
  end
end
