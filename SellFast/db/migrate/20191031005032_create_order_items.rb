class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      add_foreign_key :order_items, :orders
      add_foreign_key :order_items, :items
      t.timestamps
    end
  end
end
