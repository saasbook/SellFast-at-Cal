class BidsController < ApplicationController
	
	def bid_params
    	params.require(:bid).permit(:amount)
	end
	
	def index
		@bids = Bid.all

	end

	def show
		id = params[:id]
    	@bid = Bid.find(id)
	end

	def new
		@item = Item.find_by_id(params[:item_id])
		@bid = @item.bids.new
	end

	def create
		@item = Item.find_by_id(params[:item_id])
		@bid = @item.bids.new(bid_params)
		@bid.time_bidded = DateTime.now
		@bid.bidder_id = current_user.id
		@bid.save!
		redirect_to item_path(@item)
	end

end

