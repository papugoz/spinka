class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :news_id
      t.integer :user_id
      t.text :content

      t.timestamps
    end
  end
end
