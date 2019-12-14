include PayPalCheckoutSdk::Orders
require_relative '../services/paypal_client'
require 'json'
require 'ostruct'

class PaymentsController < ApplicationController

	skip_before_action :verify_authenticity_token

	def payment_completed
		order_id = params[:orderID]
    request = OrdersGetRequest::new(order_id)
		response = PaypalClient::client::execute(request)

		# put receipt info in hash
		@receipt_info = {
			"Status Code": response.status_code.to_s,
			"Status": response.result.status,
			"Order ID": response.result.id,
			"Intent": response.result.intent,
			"Gross Amount": response.result.purchase_units[0].amount.currency_code + response.result.purchase_units[0].amount.value
		}
		links = []
    for link in response.result.links
			links.push("\t#{link["rel"]}: #{link["href"]}\tCall Type: #{link["method"]}")
		end
		@receipt_info["Links"] = links

		# update order status
		db_order_id = params[:db_order_id]
		@order = Order.find_by_id(db_order_id)
		# @order.status = "ONLINE_PENDING_DELIVERY"
		@order.status = "ONLINE_CONFIRMED_DELIVERY"
		@order.save!

		# redirect to receipt page
		redirect_to paypal_completed_path
	end

end