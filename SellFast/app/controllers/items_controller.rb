class ItemsController < ApplicationController

  def item_params
    params.require(:item).permit(:name, :description)
  end

  def index
    @items = Item.all
  end

  def new
    # default: render 'new' template
  end
  
  def create
    @item = Item.new(item_params)
    @item.status = :BIDDING
    @items.time_listed = DateTime.now
    @item.user_selling = session[:id]
    @item.save
    @item
  end

  def show
    id = params[:id]
    @item = Item.find(id)
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update_attributes!(item_params)
    flash[:notice] = "#{@item.name} was successfully updated."
    redirect_to item_path(@item)
  end

  def destroy
  end

end
