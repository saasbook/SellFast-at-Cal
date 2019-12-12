class Item < ApplicationRecord
	before_validation :make_purchase_price_nil

	validates :name, :current_price, :status, presence: true
	validates :current_price, :numericality => { :greater_than => 0 }
	validates :purchase_price, :numericality => { :greater_than => 0 }, :allow_nil => true

	def make_purchase_price_nil
		if self.purchase_price.blank?
			self.purchase_price = nil
		end
	end

	has_many_attached :images

	has_many :bids, dependent: :destroy
	belongs_to :seller, class_name: 'User'

	def self.all_status
		%w(:BIDDING, :SOLD, :EXPIRED)
	end
	
end
