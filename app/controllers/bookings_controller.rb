class BookingsController < ApplicationController
  before_action :authenticate_user!

  def create
    @booking = current_user.bookings.build(booking_params)
    if @booking.save
      redirect_to @booking.flat, notice: "Booking was successfully created."
    else
      render 'flats/show'
    end
  end

  def show
    @booking = current_user.bookings.first
    if @booking.present?
      redirect_to @booking.flat
    else
      render 'flats/show', notice: "You don't have any booking. Do you want to book now?"
    end
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :flat_id)
  end
end
