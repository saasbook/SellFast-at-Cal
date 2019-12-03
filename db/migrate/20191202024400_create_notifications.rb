class CreateNotifications < ActiveRecord::Migration[5.2]
	def change
		create_table :notifications do |t|
      t.string :status, :default => :UNREAD
      t.references :user, foreign_key: {to_table: :users}
      t.datetime :time_created
      t.string :content
      t.timestamps
		end
	end
end