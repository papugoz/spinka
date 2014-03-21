class CreateLastReadedPosts < ActiveRecord::Migration
  def change
    create_table :last_readed_posts do |t|
      t.integer :user_id
      t.integer :topic_id
      t.integer :last_post_id
      t.timestamps
      t.index :user_id
      t.index :topic_id
    end
  end
end
