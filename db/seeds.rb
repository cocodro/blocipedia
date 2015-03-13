require 'faker'

# Create Wikis
10.times do
  Wiki.create!(
    title:     Faker::Lorem.sentence,
    body:      Faker::Lorem.paragraph
  )
end
wikis = Wiki.all

# Create Sections
100.times do
  Section.create!(
    wiki:      wikis.sample,
    title:     Faker::Lorem.sentence,
    body:      Faker::Lorem.paragraph
  )
end
sections = Section.all

# Create My User
me = User.new(
  name: "Cole",
  email: "combswc@gmail.com",
  password: "password",
  role: "admin"
)
me.skip_confirmation!
me.save!

# Create My User
premium_user = User.new(
  name: "Captain Hook",
  email: "chook@gmail.com",
  password: "password",
  role: "premium"
)
premium_user.skip_confirmation!
premium_user.save!

# Create My User
standard_user = User.new(
  name: "Captain Beefheart",
  email: "beef@heart.gov",
  password: "password"
)
standard_user.skip_confirmation!
standard_user.save!


# Create Other Users
3.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "password"
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

puts "Seeds Complete!"
puts "#{Wiki.count} wikis created!"
puts "#{Section.count} sections created!"
puts "#{User.count} users created!"
