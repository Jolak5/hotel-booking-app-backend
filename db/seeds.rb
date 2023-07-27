# db/seeds.rb

# Clear existing data
Hotel.destroy_all

# Create new hotels
3.times do |i|
  hotel = Hotel.create(
    name: "Hotel #{i + 1}",
    description: "This is a description for Hotel #{i + 1}.",
    duration: rand(1..7), # Random duration between 1 and 7
    price: rand(100.0..500.0).round(2) # Random price between 100 and 500
  )

  # Attach an image to the hotel
  hotel.image.attach(
    io: File.open(Rails.root.join('app', 'assets', 'images', 'seeds', "image#{i + 1}.jpg")),
    filename: "image#{i + 1}.jpg",
    content_type: 'image/jpg'
  )
end
