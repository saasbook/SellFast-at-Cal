class OrdersController < ApplicationController

	before_action :check_buyer_identity, :only =>[:payment, :buyer_confirm_delivery]

  # check buyer identity
  def check_buyer_identity
    @order = Order.find_by_id(params[:id])
		if current_user.id != @order.buyer_id
			flash[:danger] = "Unathorized access"
			redirect_to items_path
		end
  end
	
	def show
		@order = Order.find_by_id(params[:id])

		# @seller_decide_method = false
		# @buyer_pending_method = false
		# @seller_pending_method = false
		# @buyer_accept_method = false
		@seller_pending_payment = false
		@buyer_pay_online = false
		# @location_handshake = false
		@buyer_pending_delivery = false
		@seller_pending_delivery = false
		@completed = false

		## different routes for diffrent stages of the transaction lifecycle
		if current_user.id == @order.buyer_id
			case @order.status
			# # buyer pending payment methods
			# when "PENDING_SELLER_METHOD"
			# 	@buyer_pending_method = true
			# # buyer accept payment method
			# when "PENDING_BUYER_METHOD"
			# 	@buyer_accept_method = true
			# buyer pay online
			when "ONLINE_PENDING_PAYMENT"
				@buyer_pay_online = true
			# # location handshake
			# when "ONLINE_PENDING_DELIVERY"
			# 	@location_handshake = true
			# buyer pending delivery
			when "ONLINE_CONFIRMED_DELIVERY"
				@buyer_pending_delivery = true
			# completed
			when "COMPLETED"
				@completed = true
			end

		elsif current_user.id == @order.seller_id
			case @order.status
			# # seller choose payment methods
			# when "PENDING_SELLER_METHOD"
			# 	@seller_decide_method = true
			# # seller waiting for buyer to decide on method
			# when "PENDING_BUYER_METHOD"
			# 	@seller_pending_method = true
			# seller waiting for buyer to pay
			when "ONLINE_PENDING_PAYMENT"
				@seller_pending_payment = true
			# # seller pending delivery
			# when "ONLINE_PENDING_DELIVERY"
			# 	@location_handshake = true
			# seller pending delivery
			when "ONLINE_CONFIRMED_DELIVERY"
				@seller_pending_delivery = true
			# completed
			when "COMPLETED"
				@completed = true
			end
		else
			flash[:danger] = "Unauthorized access to order"
			redirect_to items_path
		end
	end

	def update
	end

	def payment
		@order = Order.find_by_id(params[:id])
		if @order.status != "ONLINE_PENDING_PAYMENT"
			flash[:danger] = "Unathorized access"
			redirect_to order_path(@order.id)
		end
		@item = Item.find_by_id(@order.item_id)
	end

	def buyer_confirm_delivery
		@order = Order.find_by_id(params[:id])
		if @order.status != "ONLINE_CONFIRMED_DELIVERY"
			flash[:danger] = "Unathorized access"
			redirect_to order_path(@order.id)
		end

		# send job to payout worker to pay seller
		PayoutWorker.perform_async(@order.seller_id, @order.id ,@order.amount)

		@order.status = "COMPLETED"
		@order.save!

		redirect_to order_path(@order.id)
	end

end
