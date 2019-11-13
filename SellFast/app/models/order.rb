class Order < ApplicationRecord
    validates :seller_id, :buyer_id, :status, :amount, :item_id, presence: true

	def self.all_status
		%w(:PENDING_ACTION, :PENDING_DELIVERY, :DELIVERED)
	end
	
end
