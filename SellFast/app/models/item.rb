class Item < ApplicationRecord
    validates :name, :current_price, :status, presence: true, uniqueness: true
    has_many :bids
    def self.all_status
        %w(:BIDDING, :SOLD)
    end
end
