class ItemsController < ApplicationController

  skip_before_action :authenticate!, :only =>[:index]

  def item_params
    params.require(:item).permit(:name, :description, :current_price)
  end

  def index
    @items = Item.all
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
