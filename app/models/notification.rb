class Notification < ApplicationRecord
	belongs_to :user, class_name: 'User'

	def self.all_status
		%w(:UNREAD, :READ)
	end
	
end
