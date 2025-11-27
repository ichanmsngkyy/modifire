class Gun < ApplicationRecord
  has_one_attached :base_image
  has_many :gun_attachments
  has_many :attachments, through: :gun_attachments
  has_many :builds

  enum :category, { rifle: 0, pistol: 1, smg: 2, shotgun: 3, sniper: 4 }
  serialize :allowed_attachment_types, coder: JSON
end
