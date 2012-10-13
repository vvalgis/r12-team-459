class CreateUserEntries < ActiveRecord::Migration
  def change
    create_table :user_entries do |t|
      t.references :user
      t.references :entry
      t.references :category

      t.timestamps
    end
    add_index :user_entries, :user_id
    add_index :user_entries, :entry_id
    add_index :user_entries, :category_id
  end
end
