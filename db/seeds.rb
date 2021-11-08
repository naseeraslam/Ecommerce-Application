# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
def image_fetcher
  open(Faker::Avatar.image)
rescue StandardError
  open('https://source.unsplash.com/user/erondu/50x50')
end

def product_fetcher
  open(Faker::Avatar.image)
rescue StandardError
  open('https://source.unsplash.com/user/erondu/600x600')
end

user = User.create(
  email: 'naseer.aslam456@gmail.com',
  first_name: 'Naseer',
  last_name: 'Aslam',
  password: '123456',
  password_confirmation: '123456'
)
user.avatar.attach({
                     io: image_fetcher,
                     filename: '0_user_image.jpg'
                   })
15.times do |n|
  user = User.create(
    email: Faker::Internet.unique.email,
    first_name: Faker::Name.unique.name,
    last_name: Faker::Name.unique.name,
    password: '123456',
    password_confirmation: '123456'
  )
  user.avatar.attach({
                       io: image_fetcher,
                       filename: "#{n}_user_image.jpg"
                     })
end

5.times do |n|
  user = Product.create(
    product_name: Faker::Vehicle.unique.make,
    product_price: Faker::Number.number(digits: 3),
    product_description: Faker::Name.unique.name,
    product_serial_number: Faker::IDNumber.unique.valid,
    user_id: n,
    quantity: Faker::Number.number(digits: 5)
  )
  user.images.attach({
                       io: product_fetcher,
                       filename: "#{n}_product_image.jpg"
                     })
end
20.times do |n|
  user = Product.create(
    product_name: Faker::Drone.unique.name,
    product_price: Faker::Number.number(digits: 3),
    product_description: Faker::Name.unique.name,
    product_serial_number: Faker::IDNumber.unique.valid,
    user_id: n,
    quantity: Faker::Number.number(digits: 5)
  )
  user.images.attach({
                       io: product_fetcher,
                       filename: "#{n + 5}_product_image.jpg"
                     })
end
