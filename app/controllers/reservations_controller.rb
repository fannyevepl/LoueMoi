class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:new, :create]
  before_action :set_reservation, only: [:show, :destroy, :accept, :cancel]
  def index
    today = Date.today
    # Update "ongoing" reservations to "finished" if the end date has passed
    current_user.reservations.where(status: 'ongoing').where('end_date < ?', today).update_all(status: 'finished')
    # Reservations user made
    @my_active_reservations = current_user.reservations.includes(:item).where(status: 'pending')
    @my_ongoing_reservations = current_user.reservations.includes(:item).where(status: 'ongoing').where('end_date >= ?', today)
    @my_past_reservations = current_user.reservations.includes(:item).where(status: ['finished', 'canceled'])
    # Reservations for items owned by current user
    @reservations_for_my_items = Reservation.joins(:item)
                                            .where(items: { user_id: current_user.id })
                                            .where(status: 'pending')
    @ongoing_reservations_for_my_items = Reservation.joins(:item)
                                                    .where(items: { user_id: current_user.id })
                                                    .where(status: 'ongoing')
                                                    .where('end_date >= ?', today)
    @past_reservations_for_my_items = Reservation.joins(:item)
                                                 .where(items: { user_id: current_user.id })
                                                 .where(status: ['finished', 'canceled'])
  end
  def accept
    @reservation.update(status: 'ongoing')
    redirect_to reservations_path, notice: 'Reservation has been accepted and is now ongoing.'
  end
  def cancel
    @reservation.update(status: 'canceled')
    redirect_to reservations_path, notice: 'Reservation has been canceled.'
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
