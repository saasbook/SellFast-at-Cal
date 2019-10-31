class UserList < ApplicationRecord
    def self.all_types
        %w(BUY, SELL)
    end
end
