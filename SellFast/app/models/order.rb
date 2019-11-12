class Order < ApplicationRecord
    validates :seller, :buyer, :status, :amount, :item, presence: true

	def self.all_status
		%w(:PENDING_ACTION, :PENDING_DELIVERY, :DELIVERED)
	end
	
end
