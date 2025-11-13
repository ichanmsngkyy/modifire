class ChangeCategoryToIntegerInGuns < ActiveRecord::Migration[6.0]
  def up
    add_column :guns, :category_tmp, :integer

    Gun.reset_column_information
    Gun.find_each do |gun|
      case gun.category
      when "rifle" then gun.update_column(:category_tmp, 0)
      when "pistol" then gun.update_column(:category_tmp, 1)
      when "smg" then gun.update_column(:category_tmp, 2)
      when "shotgun" then gun.update_column(:category_tmp, 3)
      when "sniper" then gun.update_column(:category_tmp, 4)
      end
    end

    remove_column :guns, :category
    rename_column :guns, :category_tmp, :category
  end

  def down
    add_column :guns, :category_tmp, :string

    Gun.reset_column_information
    Gun.find_each do |gun|
      case gun.category
      when 0 then gun.update_column(:category_tmp, "rifle")
      when 1 then gun.update_column(:category_tmp, "pistol")
      when 2 then gun.update_column(:category_tmp, "smg")
      when 3 then gun.update_column(:category_tmp, "shotgun")
      when 4 then gun.update_column(:category_tmp, "sniper")
      end
    end

    remove_column :guns, :category
    rename_column :guns, :category_tmp, :category
  end
end
