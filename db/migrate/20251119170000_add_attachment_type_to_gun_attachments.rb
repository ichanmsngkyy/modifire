class AddAttachmentTypeToGunAttachments < ActiveRecord::Migration[8.1]
  def change
    add_column :gun_attachments, :attachment_type, :string
  end
end
