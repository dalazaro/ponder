# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#p "Hello from seeds.rb"
User.delete_all

users_data = []

10.times do
  users_data << {
    username: FFaker::Internet.user_name,
    email: FFaker::Internet.safe_email,
    password: FFaker::Internet.password
  }
end

users = User.create(users_data)
puts "Seeded #{users.count} users"
