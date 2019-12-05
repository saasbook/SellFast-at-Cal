class BidsController < ApplicationController
	
	before_action :check_not_owner, :check_item_is_bidding, :check_highest_price, :check_bid_lower_than_buy_it_now , only: [:create]

	def bid_params
		params.require(:bid).permit(:amount)
	end

	# validation functions for creating bids
	def check_highest_price
		@item = Item.find_by_id(params[:item_id])
		if @item.current_price >= bid_params[:amount].to_f
			flash[:danger] = "Bidding price must be higher than the price to beat"
			redirect_to item_path(@item)
		end
	end
	
	def check_not_owner
		@item = Item.find_by_id(params[:item_id])
		if @item.seller_id == current_user.id
			flash[:danger] = "You cannot bid on your own items"
			redirect_to item_path(@item)
		end
	end

	def check_item_is_bidding
		@item = Item.find_by_id(params[:item_id])
		if @item.status != "BIDDING"
			flash[:danger] = "This item is no longer in bidding"
			redirect_to item_path(@item)
		end
	end

	def check_bid_lower_than_buy_it_now
		@item = Item.find_by_id(params[:item_id])
		if @item.purchase_price != nil && @item.purchase_price <= params[:amount]
			flash[:danger] = "You are bidding more than the buy it now price! Purchase it directly instead!"
			redirect_to item_path(@item)
		end
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
		amount = bid_params[:amount].to_f
		@item = Item.find_by_id(params[:item_id])
		@item.highest_bidder_id = current_user.id
		@item.current_price = amount
		@item.save!
		
		@bid = @item.bids.new(bid_params)
		@bid.time_bidded = DateTime.now
		@bid.bidder_id = current_user.id
		@bid.save!
		redirect_to item_path(@item)
	end

end

