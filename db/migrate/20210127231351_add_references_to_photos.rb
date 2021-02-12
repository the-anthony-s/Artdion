class AddReferencesToPhotos < ActiveRecord::Migration[6.1]
  def change
    add_reference :photos, :type, foreign_key: true, index: true
  end
end
