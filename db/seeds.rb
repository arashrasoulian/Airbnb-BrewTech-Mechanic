# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'
require "open-uri"

Flat.destroy_all

User.destroy_all

puts 'Creating 10 fake Users'

users = 10.times.map do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: 'securepassword',
    # Include any other required fields your User model may have
  )
end

puts 'Creating 10 fake Flats'
10.times do |i|
  flat = Flat.new(
    address: "#{Faker::Address.street_address}, #{Faker::Address.city}",
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    user: users[i % users.size] # This ensures each flat is associated with a user
    # Include any other required fields your Flat model may have
  )
  file = URI.open("https://source.unsplash.com/random/?apartment")
  flat.photo.attach(io: file, filename: "#{flat.address}.png", content_type: "image/png")
  flat.save!
end
