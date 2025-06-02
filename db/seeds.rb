require 'open-uri'

puts "Clearing database..."

Basket.destroy_all
BasketItem.destroy_all
PharmacyProduct.destroy_all
Product.destroy_all
Pharmacy.destroy_all
User.destroy_all

puts "Creating users..."

bob = User.create!(
  name: "Bob Smith",
  email: "bob@gmail.com",
  password: "password",
  address: "Oxford Street, London",
  pharmacist?: true
)

bob_avatar = URI.open("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpvPsX2QaxsAxFBsQbMX86oFq-QxBHw1sXxg&s")
bob.images.attach(io: bob_avatar, filename: "bob.png", content_type: "image/png")

alice = User.create!(
  name: "Alice Johnson",
  email: "alice@gmail.com",
  password: "password",
  address: "456 Elm St, Manchester",
  pharmacist?: false
)

alice_avatar = URI.open("https://img.freepik.com/premium-vector/drawing-old-woman-with-big-smile-her-face_481747-91243.jpg")
alice.images.attach(io: alice_avatar, filename: "alice.png", content_type: "image/png")

puts "Creating pharmacies..."

pharmacy1 = Pharmacy.create!(
  name: "London Pharmacy",
  location: "789 King St, London",
  description: "Your one-stop shop for all your pharmaceutical needs.",
  user: bob
)

pharmacy1_image = URI.open("https://hopwoodspharmacy.co.uk/wp-content/uploads/2021/04/shop-front-scaled.jpg")
pharmacy1.images.attach(io: pharmacy1_image, filename: "pharmacy1.png", content_type: "image/png")

pharmacy2 = Pharmacy.create!(
  name: "Manchester Pharmacy",
  location: "101 Queen St, Manchester",
  description: "Conveniently located in the heart of Manchester for all your medication needs.",
  user: bob
)

pharmacy2_image = URI.open("https://moodsigns.co.uk/wp-content/uploads/2019/12/JD_Rapeed_AR-Chemist_Front-Elevation_A01.jpg")
pharmacy2.images.attach(io: pharmacy2_image, filename: "pharmacy2.png", content_type: "image/png")

pharmacy3 = Pharmacy.create!(
  name: "Birmingham Health",
  location: "55 High St, Birmingham",
  description: "Trusted pharmacy in Birmingham for your health needs.",
  user: bob
)

pharmacy3_image = URI.open("https://visionshopfitters.co.uk/wp-content/uploads/2019/11/Clarks-Pharmacy-Signage-And-Shopfront-design-1800x1200.jpg")
pharmacy3.images.attach(io: pharmacy3_image, filename: "pharmacy3.png", content_type: "image/png")

puts "Creating products..."

products = [
  {
    name: "Aspirin Gastro-Resistant",
    description: "Pain reliever and anti-inflammatory.",
    image: "https://eliveragroup.co.uk/cdn/shop/files/aspirin-500mg-x-10-tablets-uk-2.jpg?v=1716237739&width=1445"
  },
  {
    name: "Benylin Dry & Tickly Cough Syrup 150ml",
    description: "Relieves tickly cough and soothes throat.",
    image: "https://m.media-amazon.com/images/I/71j54nhwEkL._AC_UF894,1000_QL80_.jpg"
  },
  {
    name: "Aspirin 500mg x 10 tablets",
    description: "Pain reliever and anti-inflammatory.",
    image: "https://eliveragroup.co.uk/cdn/shop/files/aspirin-500mg-x-10-tablets-uk-2.jpg?v=1716237739&width=1445"
  },
  {
    name: "Covonia Chesty Cough Sugar-Free",
    description: "Relieves cough and soothes throat.",
    image: "https://d2i5j94z9qxt5a.cloudfront.net/eyJidWNrZXQiOiJ3ZWxkcmlja3MtY2RuIiwia2V5IjoicHJvZHVjdHMvNzA0Ny8ycm5jRG1tanVZZXFpZzZGS2IyUUlQNlVZU2diT2g4V0VTdEIwSlVSLnBuZyIsImVkaXRzIjp7InJlc2l6ZSI6eyJ3aWR0aCI6NjAwLCJoZWlnaHQiOjYwMCwiZml0IjoiY29udGFpbiIsImJhY2tncm91bmQiOnsiciI6MjU1LCJnIjoyNTUsImIiOjI1NSwiYWxwaGEiOjB9fSwid2VicCI6eyJxdWFsaXR5Ijo4MH19fQ=="
  },
  {
    name: "Piriteze allergy tablets 7 tablets",
    description: "Relieves allergy symptoms such as sneezing and runny nose.",
    image: "https://lloydspharmacy.com/cdn/shop/files/5000347000799_T595_2_430x.progressive.jpg?v=1711369458"
  },
  {
    name: "Fusion allergy cooling mask (1 mask)",
    description: "Cooling mask for allergy relief.",
    image: "https://lloydspharmacy.com/cdn/shop/files/6706618_01_1d1d4f89-b6a1-4c0f-9c4c-ce5d763b9bfd_430x.progressive.jpg?v=1711028747"
  },
  {
    name: "Nitrofurantoin 100mg 6 tablets",
    description: "Antibiotic for urinary tract infections.",
    image: "https://onlinedoctor.lloydspharmacy.com/image/156518/16x9/695/390/e4ac6733e0b1dcddc38c85292363085d/mG/nitrofurantoin---picture.jpg"
  }
]

product_records = products.map do |data|
  product = Product.create!(name: data[:name], description: data[:description])
  image = URI.open(data[:image])
  product.images.attach(io: image, filename: "#{product.name.parameterize}.png", content_type: "image/png")
  product
end

puts "Creating pharmacy products..."

# Attach products 1–6 to pharmacy1
product_records[0..5].each do |product|
  PharmacyProduct.create!(
    pharmacy: pharmacy1,
    product: product,
    quantity: 100,
    price: 5
  )
end

# Attach product 7 to pharmacy3
PharmacyProduct.create!(
  pharmacy: pharmacy3,
  product: product_records[6],
  quantity: 50,
  price: 10
)

puts "Creating basket..."

basket = Basket.create!(pharmacy: pharmacy1)
BasketItem.create!(basket: basket, product: product_records[0], quantity: 2)

puts "Creating order..."

Order.create!(
  user: alice,
  basket: basket,
  delivered?: false
)

puts "Seeding complete ✅"
