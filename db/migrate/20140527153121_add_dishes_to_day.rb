class AddDishesToDay < ActiveRecord::Migration
  def change
    add_column :days, :principal, :string
    add_column :days, :mistura, :string
    add_column :days, :acompanhamento, :string
    add_column :days, :salada, :string
    add_column :days, :opcional, :string
    add_column :days, :sobremesa, :string
  end
end
