class OrdersController < ApplicationController
	
	def show
		@order = Order.find_by_id(params[:id])
		@is_buyer = current_user.id == @order.buyer_id
	end

	def update
	end

	def payment
		@order = Order.find_by_id(params[:id])
		if current_user.id != @order.buyer_id
			flash[:danger] = "Unathorized access to payments page"
			redirect_to order_path(@order)
		end
		@item = Item.find_by_id(@order.item_id)
	end

end
