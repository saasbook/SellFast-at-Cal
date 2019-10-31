class CreateUserOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :user_orders do |t|
      add_foreign_key :user_orders, :users
      add_foreign_key :user_orders, :orders
      t.string :type
      t.timestamps
    end
  end
end
