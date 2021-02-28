class AddLikesCountToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :comments_likes_count, :integer, default: 0
    add_column :users, :photos_likes_count, :integer, default: 0
  end
end
