class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :status
      t.string :description
      t.float :current_price
      t.float :buy_it_now
      t.datetime :time_listed
      add_foreign_key :items, :users, column: :user_selling
      add_foreign_key :items, :users, column: :highest_bidder
      t.timestamps
    end
  end
end
