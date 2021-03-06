# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
Project.delete_all
Task.delete_all
Comment.delete_all
Membership.delete_all


admin = User.create!(
first_name: 'Admin',
last_name: 'User',
email: 'admin@example.com',
password: 'password',
admin: true
)

owner = User.create!(
first_name: 'Owner',
last_name: 'User',
email: 'owner@example.com',
password: 'password'
)

member = User.create!(
first_name: 'Member',
last_name: 'User',
email: 'member@example.com',
password: 'password'
)

user = User.create!(
first_name: 'Basic',
last_name: 'User',
email: 'user@example.com',
password: 'password'
)


tracker = User.create!(
first_name: "Dan",
last_name: "Mello",
email: "dan.mello1001@gmail.com",
password: "password",
admin: true,
tracker_token: "57a5c432c2d28039144b2c1654bd9242"
)


multiple_owners = Project.create!(name: 'Multiple Owners')
Membership.create!(
project: multiple_owners,
user: owner,
role: 'owner'
)
Membership.create!(
project: multiple_owners,
user: user,
role: 'owner'
)
Membership.create!(
project: multiple_owners,
user: member,
role: 'member'
)

task1 = Task.create!(
task: "Write 3 comments",
project: multiple_owners,
due_date: 4.days.from_now
)

task2 = Task.create!(
task: "Write 1 comment",
project: multiple_owners,
due_date: 5.days.from_now
)

3.times do
  Comment.create!(
  task: task1,
  user: owner,
  description: Faker::Lorem.sentence
  )
end

Comment.create!(
task: task2,
user: member,
description: Faker::Lorem.sentence
)

single_owner = Project.create!(name: 'Single Owner')
Membership.create!(
project: single_owner,
user: owner,
role: 'owner'
)
Membership.create!(
project: single_owner,
user: member,
role: 'member'
)
