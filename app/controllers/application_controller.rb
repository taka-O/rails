class ApplicationController < ActionController::API
  before_action :authenticate!

  def authenticate!
    authorization_header = request.headers[:Authorization]
    if !authorization_header
      render_unauthorized
    else
      token = authorization_header.split(" ")[1]
      secret_key = Rails.application.credentials.secret_key_base

      begin
        @current_user = User.find_by_token(token: token, secret_key: secret_key)
      rescue JWT::DecodeError, ActiveRecord::RecordNotFound
        render_unauthorized
      end
    end
  end

  def current_user
    @current_user
  end

  def render_unauthorized
    render json: { errors: 'Unauthorized' }, status: :unauthorized
  end
end
