class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    # List all flats
    @flats = Flat.all
    # Initialize new booking
    @booking = Booking.new
    # The `geocoded` scope filters only flats with coordinates
    @markers = @flats.geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude
      }
    end
  end

end
