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

Basket.destroy_all
PharmacyProduct.destroy_all
Product.destroy_all
Pharmacy.destroy_all
User.destroy_all


puts "creating users"

bob = User.create!(
  name: "Bob Smith",
  email: "bob@gmail.com",
  password: "password",
  address: "Oxford Street, London",
  pharmacist?: true
)

file = URI.parse("https://hopwoodspharmacy.co.uk/wp-content/uploads/2021/04/shop-front-scaled.jpg").open
bob.images.attach(io: file, filename: "nes.png", content_type: "image/png")

alice = User.create!(
  name: "Alice Johnson",
  email: "alice@gmail.com",
  password: "password",
  address: "456 Elm St, Manchester",
  pharmacist?: false
)

file = URI.parse("https://hopwoodspharmacy.co.uk/wp-content/uploads/2021/04/shop-front-scaled.jpg").open
alice.images.attach(io: file, filename: "nes.png", content_type: "image/png")

puts "creating pharmacies"

p1 = Pharmacy.create!(
  name: "London Pharmacy",
  location: "789 King St, London",
  description: "Your one-stop shop for all your pharmaceutical needs.",
  user: bob
)

file = URI.parse("https://hopwoodspharmacy.co.uk/wp-content/uploads/2021/04/shop-front-scaled.jpg").open
p1.images.attach(io: file, filename: "nes.png", content_type: "image/png")

p2 = Pharmacy.create!(
  name: "Manchester Pharmacy",
  location: "101 Queen St, Manchester",
  description: "Conveniently located in the heart of Manchester for all your medication needs.",
  user: bob
)

file = URI.parse("https://moodsigns.co.uk/wp-content/uploads/2019/12/JD_Rapeed_AR-Chemist_Front-Elevation_A01.jpg").open
p2.images.attach(io: file, filename: "nes.png", content_type: "image/png")


p3 = Pharmacy.create!(
  name: "Birmingham Health",
  location: "55 High St, Birmingham",
  description: "Trusted pharmacy in Birmingham for your health needs.",
  user: bob
)

file = URI.parse("https://visionshopfitters.co.uk/wp-content/uploads/2019/11/Clarks-Pharmacy-Signage-And-Shopfront-design-1800x1200.jpg").open
p3.images.attach(io: file, filename: "nes.png", content_type: "image/png")


puts "creating products"

pr1 = Product.create!(
  name: "Aspirin",
  description: "Pain reliever and anti-inflammatory."
)

file = URI.parse("https://hopwoodspharmacy.co.uk/wp-content/uploads/2021/04/shop-front-scaled.jpg").open
pr1.images.attach(io: file, filename: "nes.png", content_type: "image/png")

pr2 = Product.create!(
  name: "Cough Syrup",
  description: "Relieves cough and soothes throat."
)

file = URI.parse("https://hopwoodspharmacy.co.uk/wp-content/uploads/2021/04/shop-front-scaled.jpg").open
pr2.images.attach(io: file, filename: "nes.png", content_type: "image/png")

puts "creating pharmacy products"

PharmacyProduct.create!(
  pharmacy_id: Pharmacy.first.id,
  product_id: Product.first.id,
  quantity: 100,
  price: 5
)

PharmacyProduct.create!(
  pharmacy_id: Pharmacy.first.id,
  product_id: Product.second.id,
  quantity: 100,
  price: 5
)

PharmacyProduct.create!(
  pharmacy_id: Pharmacy.first.id,
  product_id: Product.third.id,
  quantity: 100,
  price: 5
)

PharmacyProduct.create!(
  pharmacy_id: Pharmacy.first.id,
  product_id: Product.fourth.id,
  quantity: 100,
  price: 5
)

PharmacyProduct.create!(
  pharmacy_id: Pharmacy.first.id,
  product_id: Product.fifth.id,
  quantity: 100,
  price: 5
)

PharmacyProduct.create!(
  pharmacy_id: Pharmacy.first.id,
  product_id: Product.sixth.id,
  quantity: 100,
  price: 5
)

PharmacyProduct.create!(
  pharmacy_id: Pharmacy.last.id,
  product_id: Product.last.id,
  quantity: 50,
  price: 10
)

puts "creating baskets"

basket = Basket.create!(pharmacy: Pharmacy.first)
BasketItem.create!(basket: basket, product: Product.first, quantity: 2)


puts "creating orders"

Order.create!(
  user: alice,
  basket: basket,
  delivered?: false
)

puts "seeding complete"
