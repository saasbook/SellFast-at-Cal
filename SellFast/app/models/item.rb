class Item < ApplicationRecord
    validates :name, :current_price, presence: true

    def self.all_status
        %w(:BIDDING, :SOLD)
    end
end
