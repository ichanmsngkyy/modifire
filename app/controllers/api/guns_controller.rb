# app/controllers/api/guns_controller.rb
class Api::GunsController < ApplicationController
  before_action :set_gun, only: [ :show ]

  # GET /api/guns
  # Supports: ?category=rifle&search=MP5
  def index
    @guns = Gun.all
    @guns = filter_by_category(@guns) if params[:category].present?
    @guns = search_by_name(@guns) if params[:search].present?

    render json: @guns.map { |gun| gun_response(gun) }
  end

  # GET /api/guns/:id
  def show
    render json: gun_response(@gun, include_attachments: true)
  end

  private

  def set_gun
    @gun = Gun.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Gun not found" }, status: :not_found
  end

  def filter_by_category(guns)
    # Validate category exists in enum
    if Gun.categories.key?(params[:category])
      guns.where(category: params[:category])
    else
      guns # Return all if invalid category
    end
  end

  def search_by_name(guns)
    guns.where("name ILIKE ?", "%#{params[:search]}%")
  end

  def gun_response(gun, include_attachments: false)
    # If ActiveStorage image is attached, use it. Otherwise, use static public image if available.
    static_image_path = "/images/guns/#{gun.name}.png"
    static_image_full_path = Rails.root.join("public", "images", "guns", "#{gun.name}.png")
    base_image_url = if gun.base_image.attached?
      rails_blob_url(gun.base_image)
    elsif File.exist?(static_image_full_path)
      static_image_path
    else
      "/images/guns/placeholder.jpg"
    end

    response = {
      id: gun.id,
      name: gun.name,
      category: gun.category,
      description: gun.description,
      base_image_url: base_image_url,
      allowed_attachment_types: gun.allowed_attachment_types,
      created_at: gun.created_at,
      updated_at: gun.updated_at
    }

    if include_attachments
      response[:attachments] = gun.attachments.map do |attachment|
        {
          id: attachment.id,
          name: attachment.name,
          attachment_type: attachment.attachment_type,
          base_image_url: attachment.base_image.attached? ? rails_blob_url(attachment.base_image) : nil
        }
      end
    end

    response
  end
end
