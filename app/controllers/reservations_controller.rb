class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:new, :create]
  before_action :set_reservation, only: [:show, :destroy]

  def index
    # Reservations user made
    @my_reservations = current_user.reservations.includes(:item)

    # Reservations for items that belong to the current user, excluding their own reservations
    @reservations_for_my_items = Reservation.joins(:item)
                               .where(items: { user_id: current_user.id })
                               .where.not(user_id: current_user.id)
  end

  def new
    @reservation = @item.reservations.build
  end

  def show
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
    redirect_to reservations_path, notice: 'Your reservation has been cancelled.'
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date)
  end
end
