# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140409140857) do

  create_table "categories", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "custom_index"
    t.integer  "visible_posts", default: 10
  end

  create_table "comments", force: true do |t|
    t.integer  "news_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["news_id"], name: "index_comments_on_news_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "forum_layouts", force: true do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.boolean  "collapsed",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_custom_index"
    t.integer  "visible_posts",     default: 10
  end

  add_index "forum_layouts", ["category_id"], name: "index_forum_layouts_on_category_id"
  add_index "forum_layouts", ["user_id"], name: "index_forum_layouts_on_user_id"

  create_table "last_readed_posts", force: true do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.integer  "last_post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "last_readed_posts", ["topic_id"], name: "index_last_readed_posts_on_topic_id"
  add_index "last_readed_posts", ["user_id"], name: "index_last_readed_posts_on_user_id"

  create_table "news", force: true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "teaser"
  end

  add_index "news", ["user_id"], name: "index_news_on_user_id"

  create_table "posts", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["topic_id"], name: "index_posts_on_topic_id"
  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "topics", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "post_count",  default: 0
    t.datetime "last_post"
  end

  add_index "topics", ["category_id"], name: "index_topics_on_category_id"
  add_index "topics", ["user_id"], name: "index_topics_on_user_id"

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.boolean  "admin"
    t.boolean  "moderator"
    t.boolean  "editor"
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
