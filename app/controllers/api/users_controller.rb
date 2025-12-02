class Api::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin, only: [ :index, :destroy ]

  def current
    if current_user
      render json: current_user.as_json(only: [ :id, :email, :username, :role, :created_at, :updated_at ])
    else
      render json: { error: "Not authenticated" }, status: :unauthorized
    end
  end

  def index
    @users = User.all
    render json: @users.as_json(only: [ :id, :email, :username, :role, :created_at ])
  end

  def destroy
    user = User.find_by(id: params[:id])
    if user
      user.destroy
      head :no_content
    else
      head :not_found
    end
  end
end
