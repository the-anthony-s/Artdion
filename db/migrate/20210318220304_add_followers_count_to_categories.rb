class AddFollowersCountToCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :followers_count, :integer, default: 0
  end
end
