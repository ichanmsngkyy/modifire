class CreateBuildAttachments < ActiveRecord::Migration[8.1]
  def change
    create_table :build_attachments do |t|
      t.references :build, null: false, foreign_key: true
      t.references :attachment, null: false, foreign_key: true
      t.integer :x_position
      t.integer :y_position

      t.timestamps
    end
  end
end
