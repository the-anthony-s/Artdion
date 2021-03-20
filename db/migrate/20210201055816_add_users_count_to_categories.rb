class AddUsersCountToCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :users_count, :integer, default: 0
  end
end
