class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :bids, :foreign_key => 'bidder', dependent: :destroy
  has_many :items, :foreign_key => 'seller', dependent: :destroy
end
