class Build < ApplicationRecord
  belongs_to :user
  belongs_to :gun
  has_many :build_attachments, dependent: :destroy
  has_many :attachments,  through: :build_attachments
  has_many :likes
end
