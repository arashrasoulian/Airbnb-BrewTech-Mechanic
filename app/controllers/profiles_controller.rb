class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
    @bookings = @user.bookings
    # Assuming you have a Booking model related to User
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
    params.require(:user).permit(:first_name, :last_name, :email) # Add any other user attributes
  end
end
