class AddUsersCountToClassifications < ActiveRecord::Migration[6.1]
  def change
    add_column :classifications, :users_count, :integer, default: 0
  end
end
