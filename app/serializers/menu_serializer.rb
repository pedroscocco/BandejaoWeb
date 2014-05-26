class MenuSerializer < ActiveModel::Serializer
  attributes :id, :restaurant, :date

  has_many :days
end
