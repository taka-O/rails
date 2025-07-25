class Api::AnnouncementsController < ApplicationController
  def index
    announcements = Announcement.available(current_user, Time.zone.now)
    announcements = announcements.page(params[:page]).per(params[:per])

    render :index, formats: :json, locals: { announcements: announcements }
  end
end
