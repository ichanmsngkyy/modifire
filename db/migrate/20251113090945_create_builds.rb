class CreateBuilds < ActiveRecord::Migration[8.1]
  def change
    create_table :builds do |t|
      t.references :user, null: false, foreign_key: true
      t.references :gun, null: false, foreign_key: true
      t.string :name
      t.string :slug
      t.boolean :is_public
      t.integer :likes_count, default: 0

      t.timestamps
    end
  end
end
