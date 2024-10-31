class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:new, :create]
  # before_action :set_reservation, only: [:show, :destroy]

  def new
    @reservation = @item.reservations.build
  end

  def show
    @reservations = current_user.reservations.includes(:item)
  end

  def create
    @reservation = @item.reservations.build(reservation_params.merge(user: current_user, status: :pending))
    if @reservation.save
      redirect_to reservations_path, notice: 'Your reservation is pending confirmation.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation.destroy
    redirect_to reservation_path, notice: 'Your reservation has been cancelled.'
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date)
  end
end
