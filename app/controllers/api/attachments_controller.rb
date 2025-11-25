class Api::AttachmentsController < ApplicationController
  def index
    if params[:category].present?
      @attachments = Attachment.where(category: params[:category])
    else
      @attachments = Attachment.all
    end
    render json: @attachments.map { |attachment| attachment_response(attachment) }
  end

  def show
    @attachment = Attachment.find(params[:id])
    render json: attachment_response(@attachment)
  end

  private

  def attachment_response(attachment)
    static_image_path = "/images/attachments/#{attachment.name}.png"
    static_image_full_path = Rails.root.join("public", "images", "attachments", "#{attachment.name}.png")
    base_image_url = if attachment.base_image.attached?
      rails_blob_url(attachment.base_image)
    elsif File.exist?(static_image_full_path)
      static_image_path
    else
      "/images/attachments/placeholder.jpg"
    end

    {
      id: attachment.id,
      name: attachment.name,
      attachment_type: attachment.attachment_type,
      description: attachment.description,
      base_image_url: base_image_url,
      created_at: attachment.created_at,
      updated_at: attachment.updated_at
    }
  end
end
