class AddAttachmentOverlaysToBuilds < ActiveRecord::Migration[8.1]
  def change
    add_column :builds, :attachment_overlays, :jsonb, default: []
  end
end
