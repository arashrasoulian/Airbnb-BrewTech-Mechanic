class Flat < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :reviews
  validates :picture, presence: true
end
