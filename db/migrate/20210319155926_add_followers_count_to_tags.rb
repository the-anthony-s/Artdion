class AddFollowersCountToTags < ActiveRecord::Migration[6.1]
  def change
    add_column :tags, :followers_count, :integer, default: 0
  end
end
