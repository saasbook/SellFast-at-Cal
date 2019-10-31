class CreateUserLists < ActiveRecord::Migration[6.0]
  def change
    create_table :user_lists do |t|
      add_foreign_key :user_lists, :users
      add_foreign_key :user_lists, :lists
      t.string :type
      t.timestamps
    end
  end
end
