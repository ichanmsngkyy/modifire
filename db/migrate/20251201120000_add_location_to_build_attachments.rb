class AddLocationToBuildAttachments < ActiveRecord::Migration[8.1]
  def change
    add_column :build_attachments, :location, :jsonb, default: {}
  end
end
