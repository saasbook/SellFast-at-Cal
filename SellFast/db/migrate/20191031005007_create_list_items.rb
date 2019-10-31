class CreateListItems < ActiveRecord::Migration[6.0]
  def change
    create_table :list_items do |t|
      add_foreign_key :item_lists, :lists
      add_foreign_key :item_lists, :items
      t.timestamps
    end
  end
end
