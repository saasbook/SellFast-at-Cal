class CreateMarketplace < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :status, :default => :BIDDING
      t.string :description
      t.float :current_price
      t.float :purchase_price
      t.datetime :time_listed
      t.references :seller, foreign_key: {to_table: :users}
      t.integer :highest_bidder
      t.timestamps
    end
    
    create_table :users do |t|
      t.string :username
      t.string :email
      t.timestamps
    end

    create_table :bids do |t|
      t.references :item, foreign_key: {to_table: :items}
      t.references :bidder, foreign_key: {to_table: :users}
      t.float :amount
      t.datetime :time_bidded
      t.timestamps
    end
  end
end
