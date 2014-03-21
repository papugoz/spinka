namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    create_admin
    create_users
    create_news
    create_comments
    populate_forum
    Topic.all.each do |topic|
      topic.last_post = topic.posts.first.created_at
      topic.post_count = topic.posts.count
      topic.save
    end
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
    100.times do |n|
      username  = "#{Faker::Lorem.word}#{n+1}"
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
    50.times do |n|
      title = Faker::Lorem.sentence(5)
      teaser = Faker::Lorem.sentence(10)
      content = Faker::Lorem.paragraph(50)
      user.news.create!(title: title, teaser: teaser, content: content)
    end
  end

  def create_comments
    600.times do
      user_offset = rand(User.count)
      random_user = User.first(offset: user_offset)
      news_offset = rand(News.count)
      random_news = News.first(offset: news_offset)
      content = Faker::Lorem.sentence(8)
      Comment.create!(content: content, user_id: random_user.id, news_id: random_news.id)
    end
  end

  def populate_forum
    create_categories
    create_topics
    create_posts
  end

  def create_categories
    6.times do |n|
      title = Faker::Lorem.words(3).join(" ")
      Category.create!(title: title)
    end
  end

  def create_topics
    300.times do |n|
      title = Faker::Lorem.sentence(4)
      content = Faker::Lorem.paragraph(25)
      user_offset = rand(User.count)
      random_user = User.first(offset: user_offset)
      category_offset = rand(Category.count)
      random_category = Category.first(offset: category_offset)

      Topic.create!(title: "#{title}-#{n}", content: content, user_id: random_user.id, category_id: random_category.id)
    end
  end

  def create_posts
    10000.times do
      content = Faker::Lorem.paragraph(10)
      user_offset = rand(User.count)
      random_user = User.first(offset: user_offset)
      topic_offset = rand(Topic.count)
      random_topic = Topic.first(offset: topic_offset)

      Post.create!(content: content, user_id: random_user.id, topic_id: random_topic.id)
    end
  end

end