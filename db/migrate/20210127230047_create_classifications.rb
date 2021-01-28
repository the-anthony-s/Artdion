class CreateClassifications < ActiveRecord::Migration[6.1]
  def change
    create_table :classifications do |t|
      t.string :name
      t.text :description
      t.boolean :active, default: true

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Classification.create_translation_table! name: :string, description: :text
      end

      dir.down do
        Classification.drop_translation_table!
      end
    end
  end
end
