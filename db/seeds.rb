# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(username: "matt", password: "password")
User.create!(username: "test", password: "password")

30.times do
  User.create!(username: Faker::Internet.user_name, password: Faker::Internet.password)
end

SUBS = [lambda{Faker::Book.genre}, lambda{Faker::Commerce.department}, lambda{Faker::Team.sport}]
all_users = User.all.to_a

20.times do
  Sub.create!(title: SUBS.sample.call, description: Faker::Hipster.sentence(8), moderator_id: all_users.sample.id)
end

POST_TITLES = [lambda{Faker::Hacker.say_something_smart},
  lambda{Faker::StarWars.quote}, lambda{Faker::ChuckNorris.fact},
  lambda{Faker::ChuckNorris.fact}]
  # Because why wouldn't Chuck Norris facts be most likely on Reddit?

100.times do
  Post.create!(title: POST_TITLES.sample.call, url: Faker::Internet.url,
  content: Faker::Hipster.paragraph(3, 3), author_id: User.all.sample.id)
end

Post.all.each do |post|
  num_of_subs = rand(4) + 1
  sub_ids = []
  num_of_subs.times {sub_ids << rand(Sub.all.length) + 1 }
  sub_ids.uniq.each do |sub_id|
    PostSub.create!(post_id: post.id, sub_id: sub_id)
  end
end

num_posts = Post.all.length
num_users = User.all.length

# Top level comments.
100.times do
  post_id = rand(num_posts) + 1
  user_id = rand(num_users) + 1
  Comment.create!(content: Faker::Hipster.paragraph(1, 2), author_id: user_id,
  post_id: post_id)
end

num_comments = Comment.all.length

200.times do
  post_id = rand(num_posts) + 1
  user_id = rand(num_users) + 1
  comments_on_post = Post.find(post_id).comments
  comment_ids = comments_on_post.map { |comment| comment.id }
  comment_ids << nil
  parent_comment_id = comment_ids.sample
  Comment.create!(content: Faker::Hipster.paragraph(1, 2), author_id: user_id,
  post_id: post_id, parent_comment_id: parent_comment_id)
end

num_comments = Comment.all.length

400.times do
  post_id = rand(num_posts) + 1
  user_id = rand(num_users) + 1
  comments_on_post = Post.find(post_id).comments
  comment_ids = comments_on_post.map { |comment| comment.id }
  comment_ids << nil
  parent_comment_id = comment_ids.sample
  Comment.create!(content: Faker::Hipster.paragraph(1, 2), author_id: user_id,
  post_id: post_id, parent_comment_id: parent_comment_id)
end
