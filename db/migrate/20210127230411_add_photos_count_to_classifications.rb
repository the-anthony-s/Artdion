class AddPhotosCountToClassifications < ActiveRecord::Migration[6.1]
  def change
    add_column :classifications, :photos_count, :integer, default: 0
  end
end
