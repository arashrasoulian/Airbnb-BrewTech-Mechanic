class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
    @my_booking_request = current_user.booking_requests
    @bookings = @user.bookings
    #maybe also here is problem with show button, since it doesn't work
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email) # here we can add any other user attribute
  end
end
