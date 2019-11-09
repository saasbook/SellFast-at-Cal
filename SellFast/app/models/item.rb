class Item < ApplicationRecord
	validates :name, :current_price, :status, presence: true
	after_find :update_status

	has_many :bids
	belongs_to :seller, class_name: 'User'

	def self.all_status
		%w(:BIDDING, :SOLD, :EXPIRED)
	end

	def update_status
		if self.status == :BIDDING
			if (self.time_listed + 1/(24*60*60)) <= DateTime.now
				self.status = :EXPIRED
				self.save!
			end
		else
			if false
				self.status == :BIDDING
			end
		end
	end
	
end
