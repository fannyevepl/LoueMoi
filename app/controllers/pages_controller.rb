class PagesController < ApplicationController
  def home
    @items = Item.all.includes(:user).order(:name)
        # The `geocoded` scope filters only items with coordinates
        @markers = @items.geocoded.map do |item|
          {
            lat: item.latitude,
            lng: item.longitude
          }
        end
  end
  def about
  end
end
