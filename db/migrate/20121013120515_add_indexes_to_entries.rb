class AddIndexesToEntries < ActiveRecord::Migration
  def change
    add_index :entries, :url
    add_index :entries, :type
  end
end
