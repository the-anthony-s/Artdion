class CreateLanguages < ActiveRecord::Migration[6.1]
  def change
    create_table :languages do |t|
      t.string :name
      t.string :name_native
      t.string :iso_639_1
      t.string :iso_639_3
      t.string :iso_639_2b
      t.string :iso_639_2t
      t.integer :language_type, default: 1
      t.integer :language_scope, default: 1
      t.boolean :pause, default: true
      t.boolean :common, default: false

      t.timestamps
    end
  end
end
