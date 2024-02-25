class Flat < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :reviews

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_one_attached :photo

  include PgSearch::Model
  pg_search_scope :search_by_name_and_description,
    against: [ :name, :description , :city],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
