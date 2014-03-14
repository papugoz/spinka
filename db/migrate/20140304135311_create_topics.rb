class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.integer :category_id

      t.timestamps
    end
    add_index :topics, :user_id
    add_index :topics, :category_id
  end
end
