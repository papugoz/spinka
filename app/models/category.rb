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

	def slide_up!(user_id: "")
		unless user_id.blank?
			unless self.forum_layouts.find_by(user_id: user_id) == ForumLayout.where("user_id == ?", user_id).order("user_custom_index ASC").first
				@self_layout = self.forum_layouts.find_by(user_id: user_id)
				@category_up = ForumLayout.where("user_id == ? AND user_custom_index < ?", user_id, self.forum_layouts.find_by(user_id: user_id).user_custom_index).order("user_custom_index ASC").last
				@swap = @self_layout.user_custom_index
				@self_layout.user_custom_index = @category_up.user_custom_index
				@category_up.user_custom_index = @swap
				@category_up.save
				@self_layout.save
			end
		else
			unless self == Category.all.order(:custom_index).first
				@category_up = Category.where("custom_index < ?", self.custom_index).order("custom_index ASC").last
				@swap = self.custom_index
				self.custom_index = @category_up.custom_index
				@category_up.custom_index = @swap
				@category_up.save
				self.save
			end
		end
	end

	def slide_down!(user_id: "")
		unless user_id.blank?
			unless self.forum_layouts.find_by(user_id: user_id) == ForumLayout.where("user_id == ?", user_id).order("user_custom_index ASC").last
				@self_layout = self.forum_layouts.find_by(user_id: user_id)
				@category_down = ForumLayout.where("user_id == ? AND user_custom_index > ?", user_id, self.forum_layouts.find_by(user_id: user_id).user_custom_index).order("user_custom_index ASC").first
				@swap = self.forum_layouts.find_by(user_id: user_id).user_custom_index
				@swap = @self_layout.user_custom_index
				@self_layout.user_custom_index = @category_down.user_custom_index
				@category_down.user_custom_index = @swap
				@category_down.save
				@self_layout.save
			end		else
			unless self == Category.all.order(:custom_index).last
				@category_down = Category.where("custom_index > ?", self.custom_index).order("custom_index ASC").first
				@swap = self.custom_index
				self.custom_index = @category_down.custom_index
				@category_down.custom_index = @swap
				@category_down.save
				self.save
			end
		end
	end

	validates :title, presence: true
end
