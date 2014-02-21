class AddIndexesToComents < ActiveRecord::Migration
  def change
		add_index :comments, :news_id
		add_index :comments, :user_id
  end
end
