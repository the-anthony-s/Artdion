class AddCommentsCountToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :comments_count, :integer, default: 0
  end
end
