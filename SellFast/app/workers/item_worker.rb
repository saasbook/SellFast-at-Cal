class ItemWorker
	include Sidekiq::Worker
	sidekiq_options retry: false

	# worker function to update item status ran 24 hours after item is created
	def perform(item_id)
		@item = Item.find_by_id(item_id)
		if @item.highest_bidder_id.present?
			@item.status = :SOLD
			create_order(@item)
		else
			@item.status = :EXPIRED
		end
		@item.save!
	end
	
	def create_order(item)
		@order = Order.new
		@order.item_id = item.id
		@order.seller_id = item.seller_id
		@order.buyer_id = item.highest_bidder_id
		@order.amount = item.current_price
		@order.status = :PENDING_ACTION
		@order.time_sold = DateTime.now
		@order.save!
	end

end
