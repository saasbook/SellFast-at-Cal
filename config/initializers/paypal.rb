require 'paypal-checkout-sdk'

# Set up and return PayPal Ruby SDK environment with PayPal access credentials.
# This sample uses SandboxEnvironment. In production, use LiveEnvironment.

client_id = ENV.fetch('PAYPAL_CLIENT_ID')
client_secret = ENV.fetch('PAYPAL_CLIENT_SECRET')

PayPal::SandboxEnvironment.new(client_id, client_secret)