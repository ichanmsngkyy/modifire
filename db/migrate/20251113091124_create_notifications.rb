class CreateNotifications < ActiveRecord::Migration[8.1]
  def change
    create_table :notifications do |t|
  t.integer :recipient_id, null: false, index: true
  t.integer :actor_id, index: true
  t.string :notifiable_type
  t.integer :notifiable_id
  t.boolean :read, default: false
  t.string :message

      t.timestamps
    end
  end
end
