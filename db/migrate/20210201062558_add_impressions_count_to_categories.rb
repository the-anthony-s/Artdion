class AddImpressionsCountToCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :impressions_count, :int
  end
end
