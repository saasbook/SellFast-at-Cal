class Item < ApplicationRecord
	validates :name, :current_price, :status, presence: true

	# update status every time item is retrieved from database
	after_find do |item|
		if (item.status = :BIDDING) and ((item.time_listed + 1.day) <= DateTime.now)
			item.status = :EXPIRED
			item.save!
		end
	end

	has_many :bids
	belongs_to :seller, class_name: 'User'

	def self.all_status
		%w(:BIDDING, :SOLD, :EXPIRED)
	end
	
end
