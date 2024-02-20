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

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :flat_id)
  end
end
