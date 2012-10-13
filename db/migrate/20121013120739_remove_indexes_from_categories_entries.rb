class RemoveIndexesFromCategoriesEntries < ActiveRecord::Migration
  def up
    remove_index :categories_entries, :category_id
  end

  def down
    add_index :categories_entries, :category_id
  end
end
