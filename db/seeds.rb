# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "clearing database"

User.destroy_all
Pharmacy.destroy_all
Product.destroy_all
PharmacyProduct.destroy_all

puts "creating users"

User.create!(
  name: "Bob Smith",
  email: "bob@gmail.com",
  password: "password",
  address: "123 Main St, Springfield",
  pharmacist?: true
)
User.create!(
  name: "Alice Johnson",
  email: "alice@gmail.com",
  password: "password",
  address: "456 Elm St, Springfield",
  pharmacist?: false
)

puts "creating pharmacies"

Pharmacy.create!(
  name: "Springfield Pharmacy",
  location: "789 Oak St, Springfield",
  description: "Your one-stop shop for all your pharmaceutical needs."
)
Pharmacy.create!(
  name: "Downtown Pharmacy",
  location: "101 Pine St, Springfield",
  description: "Conveniently located downtown for all your medication needs."
)

puts "creating products"

Product.create!(
  name: "Aspirin",
  description: "Pain reliever and anti-inflammatory.",
  price: 5
)

Product.create!(
  name: "Cough Syrup",
  description: "Relieves cough and soothes throat.",
  price: 10
)

puts "creating pharmacy products"

PharmacyProduct.create!(
  pharmacy_id: Pharmacy.first.id,
  product_id: Product.first.id,
  quantity: 100
)

PharmacyProduct.create!(
  pharmacy_id: Pharmacy.last.id,
  product_id: Product.last.id,
  quantity: 50
)

puts "seeding complete"
