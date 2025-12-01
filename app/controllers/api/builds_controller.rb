
class Api::BuildsController < ApplicationController
  def index
    @builds = Build.includes(:gun)
    render json: @builds.map { |build| build_response(build) }
  end

  def show
    @build = Build.includes(:gun).find(params[:id])
    render json: build_response(@build)
  end

  def create
    build = Build.new(build_params.except(:attachment_ids))

    if build.save
      if build_params[:attachment_ids]
        build.attachments << Attachment.where(id: build_params[:attachment_ids])
      end
      render json: build, status: :created
    else
      render json: build.errors, status: :unprocessable_entity
    end
  end

  def update
    build = Build.find(params[:id])
    if build.update(build_params.except(:attachment_ids))
      if build_params[:attachment_ids]
        build.attachments = Attachment.where(id: build_params[:attachment_ids])
      end
      render json: build_response(build)
    else
      render json: build.errors, status: :unprocessable_entity
    end
  end

  def index
    @builds = Build.includes(:gun)
    render json: @builds.map { |build| build_response(build) }
  end

  def show
    @build = Build.includes(:gun).find(params[:id])
    render json: build_response(@build)
  end

  def create
    build = Build.new(build_params.except(:attachment_ids))

    if build.save
      if build_params[:attachment_ids]
        build.attachments << Attachment.where(id: build_params[:attachment_ids])
      end
      render json: build, status: :created
    else
      render json: build.errors, status: :unprocessable_entity
    end
  end

  private

  def build_response(build)
    gun = build.gun
    static_image_path = "/images/guns/#{gun&.name}.png"
    static_image_full_path = Rails.root.join("public", "images", "guns", "#{gun&.name}.png")
    base_image_url = if gun&.base_image&.attached?
      Rails.application.routes.url_helpers.rails_blob_url(gun.base_image, only_path: true)
    elsif gun && File.exist?(static_image_full_path)
      static_image_path
    else
      "/images/guns/placeholder.jpg"
    end

    {
      id: build.id,
      name: build.name,
      gun: gun && {
        id: gun.id,
        name: gun.name,
        base_image_url: base_image_url
      },
      user_id: build.user_id,
      gun_id: build.gun_id,
      attachments: build.attachments.map { |att| { id: att.id, name: att.name, attachment_type: att.attachment_type } },
      created_at: build.created_at,
      updated_at: build.updated_at
    }
  end

  def build_params
    params.require(:build).permit(:name, :user_id, :gun_id, attachment_ids: [])
  end
end
