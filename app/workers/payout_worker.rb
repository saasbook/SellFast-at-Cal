class PayoutWorker
	include Sidekiq::Worker
	require 'net/http'
	require 'uri'
	require 'json'

	sidekiq_options retry: false

	@@paypal_access_token_url = "https://api.sandbox.paypal.com/v1/oauth2/token"
	@@paypal_payout_url = "https://api.sandbox.paypal.com/v1/payments/payouts"

	def perform(seller_id, order_id, payout_amount)
		@user = User.find_by_id(seller_id)
		api_access_token = get_api_access_token

		uri = URI.parse(@@paypal_payout_url)
		request = Net::HTTP::Post.new(uri)
		request.content_type = "application/json"
		request["Authorization"] = "Bearer #{api_access_token}"

		if @user.paypal_email != nil
			# send money to seller paypal account
			request.body = JSON.dump({
				"sender_batch_header" => {
					"sender_batch_id" => DateTime.now.to_s,
					"email_subject" => "You have been paid for order id #{order_id.to_s}!",
					"email_message" => "You have been paid after successful delivery! Thanks for using SellFast!"
				},
				"items" => [
					{
						"recipient_type" => "EMAIL",
						"amount" => {
							"value" => payout_amount.to_s,
							"currency" => "USD"
						},
						"note" => "You have successfully sold item #{Item.find_by_id(Order.find_by_id(order_id).item_id).name}",
						"receiver" => @user.paypal_email
					}
				]
			})
		elsif @user.venmo_phone_number != nil
			# send money to seller venmo account
			request.body = JSON.dump({
				"sender_batch_header" => {
					"sender_batch_id" => DateTime.now.to_s,
					"email_subject" => "You have been paid for order id #{order_id.to_s}!",
					"email_message" => "You have been paid after successful delivery! Thanks for using SellFast!"
				},
				"items" => [
					{
						"recipient_type" => "PHONE",
						"amount" => {
							"value" => payout_amount.to_s,
							"currency" => "USD"
						},
						"note" => "You have successfully sold item #{Order.find_by_id(order_id).item.name}",
						"receiver" => @user.venmo_phone_number
					}
				]
			})
		else
			# handle cases when seller no longer has valid payout methods
		end
			
		req_options = {
			use_ssl: uri.scheme == "https",
		}
		
		response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
			http.request(request)
		end

	end

	def get_api_access_token
		uri = URI.parse(@@paypal_access_token_url)
		request = Net::HTTP::Post.new(uri)
		request.basic_auth("ASv3RRakkgFHKgtF7wj03AIiXz6BFoDOOPR9r1eDQYxQDm9q_QeYf3ix18rof_0k04j5RyjwVsAKXuav", "EH02lTCvZtfUAJztvDQqljn6pxiGHumftM11EkDsfL6XoHrTIGinc9idhWRpE6fP4cQuYkK2iWCifzc3")
		request["Accept"] = "application/json"
		request["Accept-Language"] = "en_US"
		request.set_form_data(
			"grant_type" => "client_credentials",
		)
		
		req_options = {
			use_ssl: uri.scheme == "https",
		}
		
		response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
			http.request(request)
		end

		return JSON.parse(response.body)["access_token"]
	end
		
end
