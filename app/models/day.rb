class Day < ActiveRecord::Base
  belongs_to :menu
  has_and_belongs_to_many :dishes
end
