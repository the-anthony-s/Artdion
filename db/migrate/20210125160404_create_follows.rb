class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.references :user
      t.references :followable, polymorphic: true, unique: true, index: true
      t.references :follower, polymorphic: true, index: true

      t.timestamps
    end
  end
end
