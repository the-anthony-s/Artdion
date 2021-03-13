class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.references :user, index: true
      t.string :name
      t.text :description
      t.text :image_data
      t.string :alt_text
      t.string :location
      t.float :longitude
      t.float :latitude
      t.boolean :download, default: true
      t.boolean :private, default: false
      t.boolean :active, default: true
      t.boolean :on_sale, default: true
      t.datetime :photo_of_the_day, default: nil

      t.timestamps
    end
  end
end
