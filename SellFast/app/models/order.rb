class Order < ApplicationRecord
    def self.all_status
        %w(PENDING, IN_PROGRESS, COMPLETED)
    end
end
