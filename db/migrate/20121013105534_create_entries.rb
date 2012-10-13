class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :user
      t.string :url
      t.text :description
      t.string :type
      t.boolean :shareable, default: false

      t.timestamps
    end
    add_index :entries, :user_id
    add_index :entries, :shareable
  end
end
