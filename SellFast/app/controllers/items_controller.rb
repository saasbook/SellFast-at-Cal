class ItemsController < ApplicationController

  def item_params
    params.require(:item).permit(:name, :description, :current_price)
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
    @item.time_listed = DateTime.now
    @item.user_selling = session[:id]
    @item.save
    redirect_to item_path(@item)
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
    @item = Item.find(params[:id])
    @item.destroy
    flash[:notice] = "Item '#{@item.name}' deleted."
    redirect_to items_path
  end

end
