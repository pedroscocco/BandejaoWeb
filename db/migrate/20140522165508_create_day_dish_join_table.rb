class CreateDayDishJoinTable < ActiveRecord::Migration
  def change
    create_join_table :days, :dishes do |t|
      t.index [:day_id, :dish_id]
      # t.index [:dish_id, :day_id]
    end
  end
end
