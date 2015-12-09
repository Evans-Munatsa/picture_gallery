class AddMenuIdToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :menu_id, :integer
  end
end
