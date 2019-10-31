class CreateUserLists < ActiveRecord::Migration[6.0]
  def change
    create_table :user_lists do |t|
      t.string :type
      t.integer :user_id
      t.integer :list_id
      t.timestamps
    end
    add_foreign_key :user_lists, :users
    add_foreign_key :user_lists, :lists
  end
end
