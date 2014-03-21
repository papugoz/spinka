class AddPostCountLastPostDateToTopic < ActiveRecord::Migration
	def change
		add_column :topics, :post_count, :integer, default: 0
		add_column :topics, :last_post, :datetime
	end
end
