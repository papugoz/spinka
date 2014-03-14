class Comment < ActiveRecord::Base
	belongs_to :news
	belongs_to :user
	validates :content, presence: true
end
