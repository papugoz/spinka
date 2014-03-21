class Category < ActiveRecord::Base
	has_many :topics
	has_many :forum_layouts, dependent: :destroy
	def to_param
		"#{id}-#{title.parameterize}"
	end

	def collapsed?(user)
		if forum_layouts.find_by_user_id(user.id)
			forum_layouts.find_by_user_id(user.id).collapsed
		else
			false
		end
	end

	def collapse!(user)
		if forum_layouts.find_by_user_id(user.id)
			@layout = forum_layouts.find_by_user_id(user.id)
			@layout.collapsed = 1
			@layout.save
		else
			forum_layouts.create!(user_id: user.id, collapsed: true)
		end
	end

	def uncollapse!(user)
		@layout = forum_layouts.find_by_user_id(user.id)
		@layout.collapsed = 0
		@layout.save
	end

	validates :title, presence: true
end
