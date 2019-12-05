class ItemsController < ApplicationController

  skip_before_action :authenticate!, :only =>[:index]
  before_action :check_ownership, :only =>[:update, :edit, :destroy]
  before_action :check_not_owner, :only =>[:buy_it_now]
  before_action :check_payment_info_exist, :only =>[:new]
  before_action :set_search

  # check ownership before edit or delete
  def check_ownership
    @item = Item.find_by_id(params[:id])
    if @item.seller_id != current_user.id
      flash[:danger] = "This item does not belong to you"
      redirect_to item_path(@item)
    end
  end

  def check_not_owner
    @item = Item.find_by_id(params[:id])
    if @item.seller_id == current_user.id
      flash[:danger] = "This item is yours"
      redirect_to item_path(@item)
    end
  end

  def check_payment_info_exist
    if current_user.venmo_phone_number == nil and current_user.paypal_email == nil
      flash[:danger] = "You need to set up payment method to become a seller"
      redirect_to edit_account_path
    end
  end

  def item_params
    params.require(:item).permit(:name, :description, :current_price, :purchase_price, images: [])
  end

  def index
    @search = Item.where(status: :BIDDING).search(params[:q])
    @items = @search.result
  end

  def new
    # default: render 'new' template
    @item = Item.new
  end
  
  def create
    @item = current_user.items.new(item_params)
    @item.time_listed = DateTime.now

    if @item.valid?
      @item.save!

      # create worker to handle status change after 24 hours
      ItemWorker.perform_in(1.day, @item.id)
      # ItemWorker.perform_in(5.minutes, @item.id)

      flash[:info] = "Item created"
      redirect_to item_path(@item)
    else
      flash[:danger] = "Invalid parameters"
      redirect_to new_item_path()
    end
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
    if not item_params[:images].nil?
      for image in item_params[:images] do
        @item.images.attach(image)
      end
    end
    @item.update(item_params.except(:images))
    flash[:info] = "#{@item.name} was successfully updated."
    redirect_to item_path(@item)
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    flash[:info] = "Item '#{@item.name}' deleted."
    redirect_to items_path
  end

  def buy_it_now
    @item = Item.find(params[:id])

    # sell item immediately
    @item.status = :SOLD
    @item.save!

    # create order
    @order = Order.new
		@order.item_id = @item.id
		@order.seller_id = @item.seller_id
		@order.buyer_id = current_user.id
		@order.amount = @item.purchase_price
		@order.status = :ONLINE_PENDING_PAYMENT
		@order.time_sold = DateTime.now
    @order.save!
    
    redirect_to order_path(@order.id)
  end

  def delete_item_image
    @item = Item.find(params[:item_id])
    @image = ActiveStorage::Blob.find_signed(params[:image_id])
    ActiveStorage::Attachment.find(@image.id).purge
    redirect_to item_path(@item)
  end

end
