class PagesController < ApplicationController
  def home
    @items = Item.all.includes(:user).order(:name)
  end
  def about
  end
end
