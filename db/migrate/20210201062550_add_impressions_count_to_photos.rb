class AddImpressionsCountToPhotos < ActiveRecord::Migration[6.1]
  def change
    add_column :photos, :impressions_count, :int
  end
end
