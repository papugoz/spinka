class Topic < ActiveRecord::Base
	belongs_to	:category
	belongs_to	:user
	has_many		:posts
	has_many		:last_readed_posts, dependent: :destroy

	default_scope { order('topics.last_post DESC') }
	def to_param
		"#{id}-#{title.parameterize}"
	end
	validates :title, presence: true
	validates :content, presence: true

	def readed?(user)
		last_readed_posts.find_by_user_id(user.id)
	end

	def read!(user, last_readed)
		if readed?(user) && posts.any?
			@last_post = last_readed_posts.find_by_user_id(user.id)
			if @last_post.last_post_id < last_readed
				@last_post.last_post_id = last_readed
			end
			@last_post.save
		else
			last_readed_posts.create!(user_id: user.id, last_post_id: last_readed)
		end
	end

	def new_posts(user)
		@last_post = last_readed_posts.find_by_user_id(user.id)
		posts.where("id > #{@last_post.last_post_id}").count
	end
end