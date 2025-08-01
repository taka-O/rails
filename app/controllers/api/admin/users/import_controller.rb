class Api::Admin::Users::ImportController < Api::Admin::ApplicationController
  def create
    form = Admin::User::ImportForm.new(file: params[:file])
    if form.save
      head :no_content
    else
      render json: form.error, status: :unprocessable_entity
    end
  end
end
