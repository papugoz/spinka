class CreateForumLayout < ActiveRecord::Migration
  def change
    create_table :forum_layouts do |t|
      t.integer :user_id
      t.integer :category_id
      t.boolean :collapsed, default: false
      t.index :user_id
      t.index :category_id
      t.timestamps
    end
  end

end
