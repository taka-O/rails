class Api::AuthController < ApplicationController
  before_action :authenticate!, only: %i[current]

  def login
    @user = User.find_by_email(login_params[:email])
    if @user&.authenticate(login_params[:password])
      token = @user.generate_token(expiration: Time.zone.now.since(7.days).to_i)
      render json: { pid: @user.pid, token: token, name: @user.name, is_verfied: @user.email_verification_at.present? }
    else
      render json: { message: "loginエラー" }, status: :unauthorized
    end
  end

  def send_reset_token
    user = User.find_by_email!(reset_password_token_params[:email])
    token = user.generate_token_for(:password_reset)
    UserMailer.reset_password(user: user, token: token, reset_url: reset_password_token_params[:reset_url]).deliver_later

    head :no_content
  end

  def reset_password
    form = Auth::ResetPasswordForm.new(reset_password_params)
    if form.save
      head :no_content
    else
      render json: form.error, status: :unprocessable_entity
    end
  end

  def current
    render json: current_user.slice(:pid, :email, :name, :role).to_json
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  def reset_password_token_params
    params.permit(:email, :reset_url)
  end

  def reset_password_params
    params.permit(:token, :password, :password_confirmation)
  end
end
