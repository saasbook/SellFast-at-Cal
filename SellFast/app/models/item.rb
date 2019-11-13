class Item < ApplicationRecord
	validates :name, :current_price, :status, presence: true

	has_many :bids, dependent: :destroy
	belongs_to :seller, class_name: 'User'

	def self.all_status
		%w(:BIDDING, :SOLD, :EXPIRED)
	end
	
end
