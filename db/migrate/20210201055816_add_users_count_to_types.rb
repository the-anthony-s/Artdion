class AddUsersCountToTypes < ActiveRecord::Migration[6.1]
  def change
    add_column :types, :users_count, :integer, default: 0
  end
end
