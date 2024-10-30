class ReservationsController < ApplicationController
  before_action :set_item, only: [:new, :create]

  def new
    @reservation = @item.reservations.build
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def create
    @reservation = @item.reservations.build(reservation_params.merge(user: current_user, status: :pending))
    if @reservation.save
      redirect_to @reservation, notice: 'Your reservation is pending confirmation.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date)
  end
end
