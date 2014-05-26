class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :restaurant
      t.date :date

      t.timestamps
    end
  end
end
