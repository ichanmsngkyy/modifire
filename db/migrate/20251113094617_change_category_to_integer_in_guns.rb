class ChangeCategoryToIntegerInGuns < ActiveRecord::Migration[6.0]
  def up
    add_column :guns, :category_tmp, :integer

    # Use an anonymous class to avoid enum issues
    gun_class = Class.new(ActiveRecord::Base) do
      self.table_name = 'guns'
    end

    gun_class.reset_column_information
    gun_class.find_each do |gun|
      value = case gun.category
      when "rifle" then 0
      when "pistol" then 1
      when "smg" then 2
      when "shotgun" then 3
      when "sniper" then 4
      else nil
      end
      gun.update_column(:category_tmp, value)
    end

    remove_column :guns, :category
    rename_column :guns, :category_tmp, :category
  end

  def down
    add_column :guns, :category_tmp, :string

    gun_class = Class.new(ActiveRecord::Base) do
      self.table_name = 'guns'
    end

    gun_class.reset_column_information
    gun_class.find_each do |gun|
      value = case gun.category
      when 0 then "rifle"
      when 1 then "pistol"
      when 2 then "smg"
      when 3 then "shotgun"
      when 4 then "sniper"
      else nil
      end
      gun.update_column(:category_tmp, value)
    end

    remove_column :guns, :category
    rename_column :guns, :category_tmp, :category
  end
end
