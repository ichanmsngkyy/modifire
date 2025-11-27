class AddAllowedAttachmentTypesToGuns < ActiveRecord::Migration[8.1]
  def change
    add_column :guns, :allowed_attachment_types, :text
  end
end
