# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Category.create!(
  [
    { name: 'Racing' },
    { name: '2d' },
    { name: 'Other' }
  ]
)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
products = []
20.times do
  products << {
    name: Faker::Game.title,
    body: Faker::Movie.quote,
    categories: Category.find([1,2,3]),
    price: 15,
    county: Faker::Name.name,
    # age_limit: Faker::Number.within(range: 1..21),
    size: 6,
    set_image: 'https://picsum.photos/300'
  }
end
Product.create!(products)
