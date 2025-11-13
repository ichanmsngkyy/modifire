class GunAttachment < ApplicationRecord
  belongs_to :gun
  belongs_to :attachment
end
