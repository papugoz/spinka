class AddCollumnModeratorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :moderator, :boolean
    add_column :users, :editor, :boolean
  end
end
