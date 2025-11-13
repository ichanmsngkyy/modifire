class Notification < ApplicationRecord
  belongs_to :actor, class_name: "User", foreign_key: :actor_id
  belongs_to :recipient, class_name: "User"
end
