class CreateGunAttachments < ActiveRecord::Migration[8.1]
  def change
    create_table :gun_attachments do |t|
      t.references :gun, null: false, foreign_key: true
      t.references :attachment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
