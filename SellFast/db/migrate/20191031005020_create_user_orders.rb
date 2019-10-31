class CreateUserOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :user_orders do |t|
      t.integer :user_id
      t.integer :order_id
      t.timestamps
    end
    add_foreign_key :user_orders, :users
    add_foreign_key :user_orders, :orders
  end
end
