class AddTitleToBuilds < ActiveRecord::Migration[8.1]
  def change
    add_column :builds, :title, :string
  end
end
