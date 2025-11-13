class Gun < ApplicationRecord
  has_one_attached :base_image
  has_many :gun_attachments
  has_many :attachments, through: :gun_attachments
  has_many :builds
end
