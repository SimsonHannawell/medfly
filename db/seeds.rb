require 'open-uri'

puts "Clearing database..."#

Order.destroy_all
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

john = User.create!(
  name: "John Doe",
  email: "john@gmail.com",
  password: "password",
  address: "123 Main St, London",
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

Alan = User.create!(
  name: "Alan Johnson",
  email: "alan@gmail.com",
  password: "password",
  address: "456 Elm St, Manchester",
  pharmacist?: false
)

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

pharmacy4 = Pharmacy.create!(
  name: "Central Pharmacy",
  location: "Church St, New Quay SA45 9NX",
  description: "Providing quality healthcare services.",
  user: john
)

pharmacy4_image = URI.open("https://lh3.googleusercontent.com/p/AF1QipNlY8_OM0whOwZfe5xxKzPCaA2nlis6fwYI_TjD=w141-h118-n-k-no-nu")
pharmacy4.images.attach(io: pharmacy4_image, filename: "pharmacy4.png", content_type: "image/png")

pharmacy5 = Pharmacy.create!(
  name: "Fferyllfa D. Powys Davies Pharmacy ",
  location: "26 High St, Blaenau Ffestiniog LL41 3AA",
  description: "Caring for your health in Leeds with a wide range of products.",
  user: john
)

pharmacy5_image = URI.open("https://lh3.googleusercontent.com/p/AF1QipODlN1k21AvkgX7JMx-8Hh2WiX7KVBGqtYkPdVq=s680-w680-h510-rw")
pharmacy5.images.attach(io: pharmacy5_image, filename: "pharmacy5.png", content_type: "image/png")

pharmacy6 = Pharmacy.create!(
  name: "Cohens Chemist",
  location: "Liverpool, 30 Argyle St, Liverpool L1 5DL",
  description: "Your trusted pharmacy in Liverpool for all your health needs.",
  user: john
)

pharmacy6_image = URI.open("https://www.cohenschemist.co.uk/wp-content/uploads/2022/01/cohens_chemist.png")
pharmacy6.images.attach(io: pharmacy6_image, filename: "pharmacy6.png", content_type: "image/png")

pharmacy7 = Pharmacy.create!(
  name: "Kensington Pharmacy",
  location: "155-157 Edge Ln, Edge Hill, Liverpool L7 2PF",
  description: "Kensington Pharmacy is a family-run business that has been serving the community for over 20 years.",
  user: john
)

pharmacy7_image = URI.open("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxMWgcdCnQIwCvWnghn4ehameGyLIaaEwzBg&s")
pharmacy7.images.attach(io: pharmacy7_image, filename: "pharmacy7.png", content_type: "image/png")

pharmacy8 = Pharmacy.create!(
  name: "Woolton Late Night Pharmacy",
  location: "267 Hunts Cross Ave, Liverpool L25 9ND",
  description: "Woolton Late Night Pharmacy is a family-run business that has been serving the community for over 20 years.",
  user: john
)

pharmacy8_image = URI.open("https://s3-media0.fl.yelpcdn.com/bphoto/TfRWFfLLjoHhVSQuhDahOA/348s.jpg")
pharmacy8.images.attach(io: pharmacy8_image, filename: "pharmacy8.png", content_type: "image/png")

pharmacy9 = Pharmacy.create!(
  name: "Manchester Pharmacy and Health Clinic",
  location: "578 Stockport Rd, Longsight, Manchester M13 0RQ",
  description: "Manchester Pharmacy and Health Clinic is a family-run business that has been serving the community for over 20 years.",
  user: bob
)

pharmacy9_image = URI.open("https://everestpharmacy.co.uk/wp-content/uploads/2021/06/Untitled-design-2021-07-13T114749.686.png")
pharmacy9.images.attach(io: pharmacy9_image, filename: "pharmacy9.png", content_type: "image/png")

pharmacy10 = Pharmacy.create!(
  name: "Cameolord Pharmacy",
  location: "16 Oxford St, Manchester M1 5AE",
  description: "Cameolord Pharmacy is a family-run business that has been serving the community for over 20 years.",
  user: bob
)

pharmacy10_image = URI.open("https://whichbiz.co.uk/wp-content/uploads/2024/04/1960cf3e-c359-4fde-a200-b308d135f27d_image_jpeg.webp")
pharmacy10.images.attach(io: pharmacy10_image, filename: "pharmacy10.png", content_type: "image/png")

pharmacy11 = Pharmacy.create!(
  name: "Ladywood Pharmacy",
  location: "16 King Edwards Rd, Birmingham B1 2PZ",
  description: "Ladywood Pharmacy is a family-run business that has been serving the community for over 20 years.",
  user: bob
)

pharmacy11_image = URI.open("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkRP4C3TSWPHQ7zdRmPV7fSWJBzj_23fa50g&s")
pharmacy11.images.attach(io: pharmacy11_image, filename: "pharmacy11.png", content_type: "image/png")

pharmacy12 = Pharmacy.create!(
  name: "Hyatt Pharmacy",
  location: "49 Bristol Rd, Birmingham B5 7TU",
  description: "Hyatt Pharmacy is a family-run business that has been serving the community for over 20 years.",
  user: bob
)

pharmacy12_image = URI.open("https://pbs.twimg.com/media/CkDL5IDWEAA3gGJ?format=jpg&name=large")
pharmacy12.images.attach(io: pharmacy12_image, filename: "pharmacy12.png", content_type: "image/png")

pharmacy13 = Pharmacy.create!(
  name: "Stag Chemist",
  location: "230 Stoney Ln, Balsall Heath, Birmingham B12 8AN",
  description: "Stag Chemist is a family-run business that has been serving the community for over 20 years.",
  user: bob
)

pharmacy13_image = URI.open("https://lh3.googleusercontent.com/gps-cs-s/AC9h4nrhDzREIA-WpQS3D3RbQhxE3ycui9tIzSVoIN_Ucro6L9NXHjJv_llIGvITxYotNtV45P5HogIGwi0Hg-u__HvEoC9O8ByVb1G-5iOkJVeyYNrtj37Ei2AsJiikSDd6mhawBeTk=s680-w680-h510-rw")
pharmacy13.images.attach(io: pharmacy13_image, filename: "pharmacy13.png", content_type: "image/png")


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
product_records[0..5].each do |product|
  PharmacyProduct.create!(
    pharmacy: pharmacy2,
    product: product,
    quantity: 100,
    price: 4
  )
end

product_records[0..5].each do |product|
  PharmacyProduct.create!(
    pharmacy: pharmacy3,
    product: product,
    quantity: 100,
    price: 3.5
  )
end
product_records[0..5].each do |product|
  PharmacyProduct.create!(
    pharmacy: pharmacy4,
    product: product,
    quantity: 100,
    price: 5
  )
end
product_records[0..5].each do |product|
  PharmacyProduct.create!(
    pharmacy: pharmacy5,
    product: product,
    quantity: 100,
    price: 5
  )
end
product_records[0..5].each do |product|
  PharmacyProduct.create!(
    pharmacy: pharmacy6,
    product: product,
    quantity: 100,
    price: 5
  )
end
product_records[0..5].each do |product|
  PharmacyProduct.create!(
    pharmacy: pharmacy7,
    product: product,
    quantity: 100,
    price: 5
  )
end
product_records[0..5].each do |product|
  PharmacyProduct.create!(
    pharmacy: pharmacy8,
    product: product,
    quantity: 100,
    price: 5
  )
end
product_records[0..5].each do |product|
  PharmacyProduct.create!(
    pharmacy: pharmacy9,
    product: product,
    quantity: 100,
    price: 5
  )
end
product_records[0..5].each do |product|
  PharmacyProduct.create!(
    pharmacy: pharmacy10,
    product: product,
    quantity: 100,
    price: 5
  )
end
product_records[0..5].each do |product|
  PharmacyProduct.create!(
    pharmacy: pharmacy11,
    product: product,
    quantity: 100,
    price: 5
  )
end
product_records[0..5].each do |product|
  PharmacyProduct.create!(
    pharmacy: pharmacy12,
    product: product,
    quantity: 100,
    price: 5
  )
end
# Attach product 7 to pharmacy13
PharmacyProduct.create!(
  pharmacy: pharmacy13,
  product: product_records[6],
  quantity: 50,
  price: 10
)

puts "Creating basket..."

basket = Basket.create!(pharmacy: pharmacy1)
BasketItem.create!(basket: basket, product: product_records[0], quantity: 2)

puts "Creating order..."

# Order.create!(
#   user: alice,
#   basket: basket,
#   delivered?: false
# )

puts "Seeding complete ✅"
