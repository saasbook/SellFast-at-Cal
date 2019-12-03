class CreateMarketplace < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username,           null: false, default: ""

      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :users, :username,             unique: true
    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true

    create_table :items do |t|
      t.string :name
      t.string :status, :default => :BIDDING
      t.string :description
      t.float :current_price
      t.float :purchase_price
      t.datetime :time_listed
      t.references :seller, foreign_key: {to_table: :users}
      t.references :highest_bidder, foreign_key: {to_table: :users}
      t.timestamps
    end

    create_table :bids do |t|
      t.references :item, foreign_key: {to_table: :items}
      t.references :bidder, foreign_key: {to_table: :users}
      t.float :amount
      t.datetime :time_bidded
      t.timestamps
    end

    create_table :orders do |t|
      t.string :status, :default => :PENDING_ACTION
      t.references :item, foreign_key: {to_table: :items}
      t.references :seller, foreign_key: {to_table: :users}
      t.references :buyer, foreign_key: {to_table: :users}
      t.float :amount
      t.datetime :time_sold
      t.datetime :transaction_time
      t.string :transaction_location
      t.timestamps
    end
  end
end
