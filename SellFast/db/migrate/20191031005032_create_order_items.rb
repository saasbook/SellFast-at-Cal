class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :item_id
      t.timestamps
    end
    add_foreign_key :order_items, :orders
    add_foreign_key :order_items, :items
  end
end
