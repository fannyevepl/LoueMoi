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

puts "Seeding items"

User.all.each do |user|
  Item.destroy_all

  category = [
    "Gardening Tools",
    "Sports Equipment",
    "DIY Tools",
    "Camping Gear",
    "Kitchen Appliances",
    "Cleaning Equipment",
    "Games and Toys",
    "Party Supplies",
    "Reading and Study Materials",
    "Transportation Equipment"
  ]

  100.times do |i|
    Item.create!(
      user: user,
      name: Faker::Commerce.product_name,
      category: category.sample,
      description: Faker::Lorem.sentence,
      address: Faker::Address.full_address
    )
  end
end

puts "Done seeding"
