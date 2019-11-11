class Bid < ApplicationRecord
    belongs_to :item, optional:true
    belongs_to :bidder, class_name: 'User'


end
