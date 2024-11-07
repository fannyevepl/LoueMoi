# app/controllers/items_controller.rb
class ItemsController < ApplicationController
  # before_action :authenticate_user!
  # before_action :set_item, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!, except: [:show]
  before_action :set_item, only: [:edit, :update, :destroy]

  def index
    @items = current_user.items
  end

  def show
    @item = Item.find(params[:id])
    @items = [@item]
    @markers = @items.map { |item| { lat: item.latitude, lng: item.longitude } }
  end

  def new
    @item = current_user.items.build
  end

  def edit
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to user_items_path, notice: 'Item was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
  if @item.update(item_params)
    # redirect_to [current_user, @item], notice: 'Item was successfully updated.'
    redirect_to user_items_path, notice: 'Item was successfully updated.'
  else
    render :edit, status: :unprocessable_entity
  end
  end

  def destroy
    @item.destroy
    redirect_to user_items_url(current_user), notice: 'Item was successfully destroyed.'
  end

  def search
    @query = params[:query]
    @items = Item.where("name ILIKE ?", "%#{@query}%")
    render 'pages/home'
  end

  private
  def set_item
    @item = current_user.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :address, :category)
  end
end
