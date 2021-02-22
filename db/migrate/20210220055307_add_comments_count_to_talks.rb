class AddCommentsCountToTalks < ActiveRecord::Migration[6.1]
  def change
    add_column :talks, :comments_count, :integer, default: 0
  end
end
