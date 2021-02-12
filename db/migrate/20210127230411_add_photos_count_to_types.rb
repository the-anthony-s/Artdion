class AddPhotosCountToTypes < ActiveRecord::Migration[6.1]
  def change
    add_column :types, :photos_count, :integer, default: 0
  end
end
