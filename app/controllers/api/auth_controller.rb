class Api::AuthController < ApplicationController
  skip_before_action :authenticate!

  def login
    @user = User.find_by_email(login_params[:email])
    if @user&.authenticate(login_params[:password])
      secret_key = Rails.application.credentials.secret_key_base
      token = @user.generate_jwt(secret_key: secret_key, expiration: Time.zone.now.since(7.days).to_i)
      render json: { pid: @user.pid, token: token, name: @user.name, is_verfied: @user.email_verification_at.present? }
    else
      render json: { message: 'loginエラー' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
