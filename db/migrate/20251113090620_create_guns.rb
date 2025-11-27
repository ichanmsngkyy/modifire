class CreateGuns < ActiveRecord::Migration[8.1]
  def change
    create_table :guns do |t|
      t.string :name
      t.text :description
  t.integer :category

      t.timestamps
    end
  end
end
