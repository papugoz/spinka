namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    create_admin
    create_users
    create_news
    create_comments
  end
  def create_admin
    User.create!(username: "Admin",
     first_name: "Marcin",
     last_name: "Ciesla",
     email: "admin@spinka.com.pl",
     password: "foobar",
     password_confirmation: "foobar",
     admin: true)
  end

  def create_users
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

  def create_news
    user = User.first
    10.times do |n|
      title = "News#{n+1}"
      teaser = Faker::Lorem.sentence(5)
      content = Faker::Lorem.paragraph(50)
      user.news.create!(title: title, teaser: teaser, content: content)
    end
  end

  def create_comments
    users = User.all(limit: 6)
    5.times do |n|
      content = Faker::Lorem.sentence(8)
      News.all.each do |news|
        users.each { |user| news.comments.create!(content: content, user_id: user.id) }
      end
    end
  end
end