class News < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC') }
	validates :title, presence: true
	validates :user_id, presence: true
	validates :content, presence: true
end
