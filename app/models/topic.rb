class Topic < ActiveRecord::Base
	belongs_to	:category
	belongs_to	:user
	has_many		:posts
	default_scope { includes(:posts).order('topics.created_at DESC, posts.created_at DESC') }
	def to_param
		"#{id}-#{title.parameterize}"
	end
end
