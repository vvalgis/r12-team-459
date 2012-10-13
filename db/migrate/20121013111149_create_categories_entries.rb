class CreateCategoriesEntries < ActiveRecord::Migration
  def change
    create_table :categories_entries, id: false do |t|
      t.references :category
      t.references :entry
    end
    add_index :categories_entries, :category_id
    add_index :categories_entries, :entry_id
    add_index :categories_entries, [:category_id, :entry_id], unique: true
  end
end
