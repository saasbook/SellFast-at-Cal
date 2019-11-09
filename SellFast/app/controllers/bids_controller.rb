class BidsController < ApplicationController

	def index

	end

	def show
		id = params[:id]
    @bid = Bid.find(id)
	end

	def new
	end

	def create
	end

end
