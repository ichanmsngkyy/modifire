class Api::BuildsController < ApplicationController
  def index
    @builds = Build.all
    render json: @builds
  end

  def show
    @build = Build.find(params[:id])
    render json: @build
  end

  def create
    build = Build.new(build_params)

    if build.save
      render json: build, status: :created
    else
      render json: build.errors, status: :unprocessable_entity
    end
  end

  private
  def build_params
    params.require(:build).permit(:name, :user_id, :gun_id, attachment_ids: [])
  end
end
