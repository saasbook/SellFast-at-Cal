class UsersController < ApplicationController

	def show
		@user = current_user
		@items = current_user.items
		@bids = current_user.bids
	end

end