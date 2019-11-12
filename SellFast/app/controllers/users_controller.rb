class UsersController < ApplicationController

	def show
		@user = current_user
		@items = current_user.items
		@bids = current_user.bids
		@buy_orders = Order.where(buyer_id: current_user.id)
		@sell_orders = Order.where(seller_id: current_user.id)
	end

end