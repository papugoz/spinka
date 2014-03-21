class Post < ActiveRecord::Base
	belongs_to :topic
	belongs_to :user
	validates :content, presence: true
	default_scope order('id ASC')
end
