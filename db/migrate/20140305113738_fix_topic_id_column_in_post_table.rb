class FixTopicIdColumnInPostTable < ActiveRecord::Migration
	def change
		rename_column :posts, :topc_id, :topic_id
	end
end
