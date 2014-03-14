class FixNewsColumn < ActiveRecord::Migration
	def change
		rename_column :news, :author_id, :user_id
	end
end
