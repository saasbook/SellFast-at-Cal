class Item < ApplicationRecord
	validates :name, :current_price, :status, presence: true
	
	has_many :bids
	belongs_to :seller, class_name: 'User'

	def self.all_status
		%w(:BIDDING, :SOLD)
	end
end
