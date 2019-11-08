class User < ApplicationRecord
    validates :username, :email, presence: true, uniqueness: true
    has_many :bids
    has_many :items
end
