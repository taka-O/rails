class Api::UsersController < ApplicationController
  def current
    render json: current_user.slice(:pid, :email, :name).to_json
  rescue => e
  end
end
