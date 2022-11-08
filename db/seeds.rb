# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
User.create!(email: 'admin@test.com', password: 'aassdd123', password_confirmation: 'aassdd123')

50.times.each do
  User.create!(email: Faker::Internet.email, password: 'aassdd123', password_confirmation: 'aassdd123')
  Category.create(name: Faker::Movie.title)
  Vehicle.create(name: Faker::Vehicle.make_and_model)
end

# if Doorkeeper::Application.count.zero?
#   Doorkeeper::Application.create(name: 'Web client', redirect_uri: '', scopes: '')
#   Doorkeeper::Application.create(name: 'IOS client', redirect_uri: '', scopes: '')
#   Doorkeeper::Application.create(name: 'Android client', redirect_uri: '', scopes: '')
# end