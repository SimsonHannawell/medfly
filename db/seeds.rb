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

file = URI.parse("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpvPsX2QaxsAxFBsQbMX86oFq-QxBHw1sXxg&s").open
bob.images.attach(io: file, filename: "nes.png", content_type: "image/png")

alice = User.create!(
  name: "Alice Johnson",
  email: "alice@gmail.com",
  password: "password",
  address: "456 Elm St, Manchester",
  pharmacist?: false
)

file = URI.parse("https://img.freepik.com/premium-vector/drawing-old-woman-with-big-smile-her-face_481747-91243.jpg").open
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
  name: "Aspirin Gastro-Resistant",
  description: "Pain reliever and anti-inflammatory."
)

file = URI.parse("https://eliveragroup.co.uk/cdn/shop/files/aspirin-500mg-x-10-tablets-uk-2.jpg?v=1716237739&width=1445").open
pr1.images.attach(io: file, filename: "nes.png", content_type: "image/png")

pr2 = Product.create!(
  name: "Benylin Dry & Tickly Cough Syrup 150ml",
  description: "Relieves tickly cough and soothes throat."
)

file = URI.parse("https://m.media-amazon.com/images/I/71j54nhwEkL._AC_UF894,1000_QL80_.jpg").open
pr2.images.attach(io: file, filename: "nes.png", content_type: "image/png")

pr3 = Product.create!(
  name: "Aspirin 500mg x 10 tablets",
  description: "Pain reliever and anti-inflammatory."
)

file = URI.parse("https://eliveragroup.co.uk/cdn/shop/files/aspirin-500mg-x-10-tablets-uk-2.jpg?v=1716237739&width=1445").open
pr3.images.attach(io: file, filename: "nes.png", content_type: "image/png")

pr4 = Product.create!(
  name: "Covonia Chesty Cough Sugar-Free",
  description: "Relieves cough and soothes throat."
)

file = URI.parse("https://d2i5j94z9qxt5a.cloudfront.net/eyJidWNrZXQiOiJ3ZWxkcmlja3MtY2RuIiwia2V5IjoicHJvZHVjdHMvNzA0Ny8ycm5jRG1tanVZZXFpZzZGS2IyUUlQNlVZU2diT2g4V0VTdEIwSlVSLnBuZyIsImVkaXRzIjp7InJlc2l6ZSI6eyJ3aWR0aCI6NjAwLCJoZWlnaHQiOjYwMCwiZml0IjoiY29udGFpbiIsImJhY2tncm91bmQiOnsiciI6MjU1LCJnIjoyNTUsImIiOjI1NSwiYWxwaGEiOjB9fSwid2VicCI6eyJxdWFsaXR5Ijo4MH19fQ==").open
pr4.images.attach(io: file, filename: "nes.png", content_type: "image/png")

pr5 = Product.create!(
  name: "Piriteze allergy tablets 7 tablets",
  description: "Relieves allergy symptoms such as sneezing and runny nose."
)

file = URI.parse("https://lloydspharmacy.com/cdn/shop/files/5000347000799_T595_2_430x.progressive.jpg?v=1711369458").open
pr5.images.attach(io: file, filename: "nes.png", content_type: "image/png")

pr6 = Product.create!(
  name: "Fusion allergy cooling mask (1 mask)",
  description: "Cooling mask for allergy relief."
)

file = URI.parse("https://lloydspharmacy.com/cdn/shop/files/6706618_01_1d1d4f89-b6a1-4c0f-9c4c-ce5d763b9bfd_430x.progressive.jpg?v=1711028747").open
pr6.images.attach(io: file, filename: "nes.png", content_type: "image/png")

pr7 = Product.create!(
  name: "Nitrofurantoin 100mg 6 tablets",
  description: "Antibiotic for urinary tract infections."
)

file = URI.parse("https://onlinedoctor.lloydspharmacy.com/image/156518/16x9/695/390/e4ac6733e0b1dcddc38c85292363085d/mG/nitrofurantoin---picture.jpg").open
pr7.images.attach(io: file, filename: "nes.png", content_type: "image/png")

puts "creating pharmacy products"

PharmacyProduct.create!(
  pharmacy_id: Pharmacy.first.id,
  product_id: Product.first.id,
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
