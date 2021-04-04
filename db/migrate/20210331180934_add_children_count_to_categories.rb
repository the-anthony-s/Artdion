class AddChildrenCountToCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :children_count, :integer, default: 0
  end
end
