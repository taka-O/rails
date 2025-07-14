class Api::Admin::ApplicationController < ApplicationController
  def authenticate!
    super

    raise NotPermittedError unless current_user.admin?
  end
end
