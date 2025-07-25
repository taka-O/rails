class ApplicationController < ActionController::API
  class NotPermittedError < StandardError; end
  before_action :authenticate!

  rescue_from NotPermittedError, with: :forbidden

  def authenticate!
    authorization_header = request.headers[:Authorization]
    if !authorization_header
      render_unauthorized
    else
      token = authorization_header.split(" ")[1]

      begin
        @current_user = User.find_by_token(token: token)
      rescue JWT::DecodeError, ActiveRecord::RecordNotFound
        render_unauthorized
      end
    end
  end

  def current_user
    @current_user
  end

  def render_unauthorized
    render json: { errors: "Unauthorized" }, status: :unauthorized
  end

  def forbidden
    render json: { errors: "Forbidden" }, status: :forbidden
  end
end
