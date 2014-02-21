class Comment < ActiveRecord::Base
	belongs_to :news
	validates :content, presence: true
end
