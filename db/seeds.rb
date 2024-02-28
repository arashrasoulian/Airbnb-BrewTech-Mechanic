# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "faker"
require "open-uri"
require "yaml"

Booking.destroy_all

Flat.destroy_all

User.destroy_all

flats = YAML.load_file(Rails.root.join("config", "flat_data.yml"))
flats_data = flats["flats"]

parises = YAML.load_file(Rails.root.join("config", "paris_flat.yml"))
parises_data = parises["parises"]

puts "Creating 10 fake Users"

users = 10.times.map do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "securepassword"
  )
end

puts "Creating 4 fake Flats in paris"
parises_data.each_with_index do |flat_data, i|
  flat = Flat.new(
    name: flat_data["name"],
    description: flat_data["description"],
    address: flat_data["address"],
    city: "paris",
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    user: users[i % users.size]
  )
  file = URI.open("https://source.unsplash.com/random/?apartment")
  flat.photo.attach(io: file, filename: "#{flat.address}.png", content_type: "image/png")

  min_price = 100
  max_price = 200
  price = rand(min_price..max_price)

  flat.price = price

  flat.save!
end

puts "Creating 12 fake Flats "
flats_data.each_with_index do |flat_data, i|
  flat = Flat.new(
    name: flat_data["name"],
    description: flat_data["description"],
    address: "#{Faker::Address.street_address}",
    city: "#{Faker::Address.city}",
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    user: users[i % users.size], # This ensures each flat is associated with a user
    # Include any other required fields your Flat model may have
  )
  file = URI.open("https://source.unsplash.com/random/?apartment")
  flat.photo.attach(io: file, filename: "#{flat.address}.png", content_type: "image/png")

  min_price = 50
  max_price = 2000
  price = rand(min_price..max_price)

  flat.price = price

  flat.save!
end
