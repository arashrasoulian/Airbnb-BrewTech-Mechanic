class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @cheapest_flats = Flat.order(price: :asc).limit(3)
    @cheapest_flats = Flat.all.where(city: params[:city]).limit(3) if params[:city].present?
    @cheapest_flats = Flat.all.where("price >= ?", params[:min_price]).limit(3) if params[:min_price].present?
    @cheapest_flats = Flat.all.where("price <= ?", params[:max_price]).limit(3) if params[:max_price].present?
    @cities = Flat.pluck(:city).uniq
    if params[:query].present?
      @flats = Flat.search_by_name_and_description(params[:query])
    else
      @flats = Flat.all
      @flats = @flats.where(city: params[:city]) if params[:city].present?
      @flats = @flats.where("price >= ?", params[:min_price]) if params[:min_price].present?
      @flats = @flats.where("price <= ?", params[:max_price]) if params[:max_price].present?
    end
    # Initialize new booking
    @booking = Booking.new
    # The `geocoded` scope filters only flats with coordinates
    # @markers = @flats.geocoded.map do |flat|
    #   {
    #     lat: flat.latitude,
    #     lng: flat.longitude
    #   }
    # end
  end

  private

  def flat_params
    params.require(:flat).permit(:name, :price, :photo, :address, :description, :city)
  end
end
