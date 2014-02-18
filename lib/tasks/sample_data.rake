namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(username: "Admin",
                 first_name: "Marcin",
                 last_name: "Ciesla",
                 email: "papugoz@gmail.com",
                 password: "miszczu",
                 password_confirmation: "miszczu",
                 admin: true)
    99.times do |n|
      username  = Faker::Internet.user_name + "#{n+1}"
      email = "user#{n+1}@testowy.org"
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      password  = "password"
      User.create!(username: username,
                   email: email,
                   first_name: first_name,
                   last_name: last_name,
                   password: password,
                   password_confirmation: password)
    end
  end
end