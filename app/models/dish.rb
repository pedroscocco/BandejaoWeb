class Dish < ActiveRecord::Base
	has_and_belongs_to_many :days
end
