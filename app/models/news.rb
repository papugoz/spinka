class News < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	default_scope -> { order('created_at DESC') }
	validates :title, presence: true
	validates :user_id, presence: true
	validates :content, presence: true
	validates :teaser, presence: true, length: { maximum: 250 }
	def to_param
		"#{id}-#{title.parameterize}"
	end

	def short_title(len)
		if title.length > len
			"#{title.first(len)}&#8230;"
		else
			title
		end
	end

end
