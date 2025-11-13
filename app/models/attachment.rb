class Attachment < ApplicationRecord
  has_one_attached :base_image
  has_many :build_attachments
  has_many :builds, through: :build_attachments
  has_many :gun_attachments
  has_many :guns, through: :gun_attachments
end
