class LastReadedPost < ActiveRecord::Base
	belongs_to :user
	belongs_to :topic
	validates :user_id, presence: true
	validates :topic_id, presence: true
	validates :last_post_id, presence: true
end
