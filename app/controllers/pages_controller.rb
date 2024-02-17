class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
      # List all flats
      @flats = Flat.all
      # Initialize new booking
      @booking = Booking.new
  end
  
end
