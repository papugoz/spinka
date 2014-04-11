class AddCustomIndexAndVisiblePostsToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :custom_index, :integer
    add_column :categories, :visible_posts, :integer, default: 10
  end
end
