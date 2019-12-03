require 'paypal-checkout-sdk'

module PayPalClient
	class << self
		
		def environment
			client_id = "ASv3RRakkgFHKgtF7wj03AIiXz6BFoDOOPR9r1eDQYxQDm9q_QeYf3ix18rof_0k04j5RyjwVsAKXuav"
			client_secret = "EH02lTCvZtfUAJztvDQqljn6pxiGHumftM11EkDsfL6XoHrTIGinc9idhWRpE6fP4cQuYkK2iWCifzc3"

      PayPal::SandboxEnvironment.new(client_id, client_secret)
    end

    # Returns PayPal HTTP client instance with environment that has access
    # credentials context. Use this instance to invoke PayPal APIs, provided the
    # credentials have access.
    def client
      PayPal::PayPalHttpClient.new(self.environment)
    end

    # Utility to convert Openstruct Object to JSON hash.
    def openstruct_to_hash(object, hash = {})
      object.each_pair do |key, value|
        hash[key] = value.is_a?(OpenStruct) ? openstruct_to_hash(value) : value.is_a?(Array) ? array_to_hash(value) : value
      end
      hash
    end

    # Utility to convert array of OpenStruct to hash.
    def array_to_hash(array, hash= [])
      array.each do |item|
        x = item.is_a?(OpenStruct) ? openstruct_to_hash(item) : item.is_a?(Array) ? array_to_hash(item) : item
        hash << x
      end
      hash
    end
  end
end