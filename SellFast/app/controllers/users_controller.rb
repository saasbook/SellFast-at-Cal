class UsersController < ApplicationController

  def user_params
    params.require(:user).permit(:username, :avatar)
  end

	def show
		@user = current_user
		@items = current_user.items
		@bids = current_user.bids
		@buy_orders = Order.where(buyer_id: current_user.id)
		@sell_orders = Order.where(seller_id: current_user.id)
	end

	def edit
		# render edit page for user
	end

	def update
		current_user.avatar.purge
		current_user.update(user_params)
    flash[:info] = "Your profile was successfully updated."
    redirect_to account_path(current_user)
	end

end