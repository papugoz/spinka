class AddTeaserToNews < ActiveRecord::Migration
  def change
    add_column :news, :teaser, :string
  end
end
