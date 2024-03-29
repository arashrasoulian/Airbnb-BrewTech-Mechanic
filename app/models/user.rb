class User < ApplicationRecord
  has_many :flats
  has_many :bookings
  has_many :reviews, through: :flats
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def booking_requests
    flats.map do |flat|
      flat.bookings
    end.flatten
  end
end
