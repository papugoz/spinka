class AddUserIdIndexToNews < ActiveRecord::Migration
	def change
		add_index :news, :user_id
	end
end
