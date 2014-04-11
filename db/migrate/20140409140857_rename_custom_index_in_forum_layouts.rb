class RenameCustomIndexInForumLayouts < ActiveRecord::Migration
  def change
  	rename_column :forum_layouts, :custom_index, :user_custom_index
  end
end
