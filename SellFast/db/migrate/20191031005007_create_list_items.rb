class CreateListItems < ActiveRecord::Migration[6.0]
  def change
    create_table :list_items do |t|
      t.integer :list_id
      t.integer :item_id
      t.timestamps
    end
    add_foreign_key :list_items, :lists
    add_foreign_key :list_items, :items
  end
end
