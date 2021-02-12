class CreateTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :types do |t|
      t.string :name
      t.text :description
      t.boolean :active, default: true

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        Type.create_translation_table! name: :string, description: :text
      end

      dir.down do
        Type.drop_translation_table!
      end
    end
  end
end
