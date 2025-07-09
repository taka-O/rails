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
        decoded_token = JWT.decode(token, secret_key)
        @current_user = User.find_by_pid(decoded_token[0]["pid"])
      rescue ActiveRecord::RecordNotFound
        render_unauthorized
      rescue JWT::DecodeError
        render_unauthorized
      end
    end
  end

  def render_unauthorized
    render json: { errors: 'Unauthorized' }, status: :unauthorized
  end
end
