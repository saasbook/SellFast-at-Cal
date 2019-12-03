class Order < ApplicationRecord
    validates :seller_id, :buyer_id, :status, :amount, :item_id, presence: true

	def self.all_status
		%w(:PENDING_METHOD, 
			:ONLINE_PENDING_PAYMENT, 
			:ONLINE_PENDING_DELIVERY,
			:ONLINE_CONFIRMED_DELIVERY,
			:COMPLETED)
	end
	
end
