require 'faker'

u = User.new(
  name: 'Admin User',
  email: 'admin@example.com', 
  password: 'helloworld', 
  password_confirmation: 'helloworld')
u.skip_confirmation!
u.save
u.update_attribute(:role, 'admin')

u = User.new(
  name: 'Moderator User',
  email: 'moderator@example.com', 
  password: 'helloworld', 
  password_confirmation: 'helloworld')
u.skip_confirmation!
u.save
u.update_attribute(:role, 'moderator')

u = User.new(
  name: 'Member User',
  email: 'member@example.com', 
  password: 'helloworld', 
  password_confirmation: 'helloworld')
u.skip_confirmation!
u.save

topics = []
15.times do
  topics << Topic.create(
    name: Faker::Lorem.words(rand(1..10)).join(" "), 
    description: Faker::Lorem.paragraph(rand(1..4))
  )

  rand(5..12).times do
  topic = topics.first # getting the first topic here
  p = u.posts.create(
    topic: topic,
    title: Faker::Lorem.words(rand(1..10)).join(" "), 
    body: Faker::Lorem.paragraphs(rand(1..4)).join("\n"))
  # set the created_at to a time within the past year
  p.update_attribute(:created_at, Time.now - rand(600..31536000))

  p.update_rank
  topics.rotate! # add this line to move the first topic to the last, so that posts get assigned to different topics.

  
  end
end

# comments...
post_count = Post.count
  User.all.each do |user|
  rand(30..50).times do
  p = Post.find(rand(1..post_count))
  c = user.comments.create(
    body: Faker::Lorem.paragraphs(rand(1..2)).join("\n"),
    post: p)
  c.update_attribute(:created_at, Time.now - rand(600..31536000))
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Topic.count} topics created"
