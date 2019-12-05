class Item < ApplicationRecord
	validates :name, :current_price, :status, presence: true
	validates :current_price, :numericality => { :greater_than => 0 }
	validates :purchase_price, :numericality => { :greater_than => 0 }

	has_many_attached :images

	has_many :bids, dependent: :destroy
	belongs_to :seller, class_name: 'User'

	def self.all_status
		%w(:BIDDING, :SOLD, :EXPIRED)
	end
	
end
