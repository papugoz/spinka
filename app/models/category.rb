class Category < ActiveRecord::Base
	has_many :topics
	def to_param
		"#{id}-#{title.parameterize}"
	end
end
