class CreateAttachments < ActiveRecord::Migration[8.1]
  def change
    create_table :attachments do |t|
      t.string :name
      t.string :attachment_type
      t.text :description
      t.integer :layer_order
      t.integer :x_position
      t.integer :y_position

      t.timestamps
    end
  end
end
