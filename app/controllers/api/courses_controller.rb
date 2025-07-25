class Api::CoursesController < ApplicationController
  def index
    courses = Course.related(current_user)
    courses = courses.eager_load(:instructors)
    courses = courses.eager_load(:students) unless current_user.student?
    courses = courses.page(params[:page]).per(params[:per])

    render :index, formats: :json, locals: { courses: courses }
  end
end
