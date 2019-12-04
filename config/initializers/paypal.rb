require 'paypal-checkout-sdk'

# Set up and return PayPal Ruby SDK environment with PayPal access credentials.
# This sample uses SandboxEnvironment. In production, use LiveEnvironment.

# client_id = ENV['PAYPAL_CLIENT_ID'] || 'PAYPAL-CLIENT-ID'
client_id = "ASv3RRakkgFHKgtF7wj03AIiXz6BFoDOOPR9r1eDQYxQDm9q_QeYf3ix18rof_0k04j5RyjwVsAKXuav"

# client_secret = ENV['PAYPAL_CLIENT_SECRET'] || 'PAYPAL-CLIENT-SECRET'
client_secret = "EH02lTCvZtfUAJztvDQqljn6pxiGHumftM11EkDsfL6XoHrTIGinc9idhWRpE6fP4cQuYkK2iWCifzc3"

PayPal::SandboxEnvironment.new(client_id, client_secret)