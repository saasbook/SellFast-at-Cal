class ItemWorker
	include Sidekiq::Worker
	sidekiq_options retry: false

	# worker function to update item status ran 24 hours after item is created
	def perform(item_id)
		@item = Item.find_by_id(item_id)
		if @item.highest_bidder.present?
			@item.status = :SOLD
		else
			@item.status = :EXPIRED
		end
		@item.save!
	end

end
