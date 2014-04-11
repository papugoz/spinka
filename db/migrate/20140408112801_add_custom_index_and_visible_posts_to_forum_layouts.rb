class AddCustomIndexAndVisiblePostsToForumLayouts < ActiveRecord::Migration
  def change
    add_column :forum_layouts, :custom_index, :integer
    add_column :forum_layouts, :visible_posts, :integer, default: 10
  end
end