class Api::Admin::UsersController < ApplicationController
  before_action :find_user, only: %i[show update destroy]

  def index
    users = User.all
    users = users.where(role: params[:role]) if params[:role].present?
    users = users.where('name LIKE ?', "%#{params[:name]}%") if params[:name].present?
    users = users.where('email LIKE ?', "%#{params[:email]}%") if params[:email].present?

    render :index, formats: :json, locals: { users: users }
  end

  def show
    render :show, formats: :json, locals: { users: @user }
  end

  def create
    form = Admin::CreateUserForm.new(user_params)
    if form.save
      render :show, formats: :json, locals: { user: form.record }, status: :created
    else
      render json: form.error, status: :unprocessable_entity
    end
  end

  def update
    form = Admin::UpdateUserForm.new(user: @user, user_params)
    if form.save
      render :show, formats: :json, locals: { user: form.record }, status: :created
    else
      render json: form.error, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!
    head :no_content
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(%i[name email role])
  end
end
