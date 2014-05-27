class DaySerializer < ActiveModel::Serializer
  attributes :id, :name, :datetime, :principal, :mistura, :acompanhamento, :salada, :opcional, :sobremesa
end
