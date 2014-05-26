class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.string :name
      t.datetime :datetime
      t.belongs_to :menu, index: true

    end
  end
end
