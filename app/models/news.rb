class News < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	default_scope -> { order('created_at DESC') }
	validates :title, presence: true
	validates :user_id, presence: true
	validates :content, presence: true
	validates :teaser, presence: true, length: { maximum: 250 }
end
