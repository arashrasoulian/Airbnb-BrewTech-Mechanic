class FlatsController < ApplicationController
  def new
    @flat = current_user.flats.build
  end

  def create
    @flat = current_user.flats.build(flat_params)
    if @flat.save
      redirect_to root_path, notice: 'Flat was successfully created.'
    else
      render :new
    end
  end

  private

  def flat_params
    params.require(:flat).permit(:name, :price, :picture, :address)
  end
end
