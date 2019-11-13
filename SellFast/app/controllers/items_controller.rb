class ItemsController < ApplicationController

  skip_before_action :authenticate!, :only =>[:index]
  before_action :check_ownership, :only =>[:update, :edit, :destroy]

  # check ownership before edit or delete
  def check_ownership
    @item = Item.find_by_id(params[:id])
    if @item.seller_id != current_user.id
      flash[:danger] = "This item does not belong to you"
      redirect_to item_path(@item)
    end
  end

  def item_params
    params.require(:item).permit(:name, :description, :current_price)
  end

  def index
    @items = Item.where(status: :BIDDING)
  end

  def new
    # default: render 'new' template
    @item = Item.new
  end
  
  def create
    @item = current_user.items.new(item_params)
    @item.time_listed = DateTime.now
    @item.save!

    # create worker to handle status change after 24 hours
    ItemWorker.perform_in(1.day, @item.id)

    redirect_to item_path(@item)
  end

  def show
    id = params[:id]
    @item = Item.find(id)
    @own = @item.seller_id == current_user.id
    @bids = @item.bids
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update_attributes!(item_params)
    flash[:info] = "#{@item.name} was successfully updated."
    redirect_to item_path(@item)
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    flash[:info] = "Item '#{@item.name}' deleted."
    redirect_to items_path
  end

end
