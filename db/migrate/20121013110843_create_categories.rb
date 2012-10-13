class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.references :user
      t.string :name

      t.timestamps
    end
    add_index :categories, :user_id
  end
end
