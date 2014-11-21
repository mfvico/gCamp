# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Project.delete_all
Task.delete_all
User.delete_all
Membership.delete_all
Comment.delete_all

50.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "1234",
    password_confirmation: "1234"
  )
end

23.times do
  project = Project.create!(name: Faker::Lorem.word)

  rand(15).times do
    task = Task.create!(
      project_id: project.id,
      task: Faker::Lorem.word,
      due_date: Faker::Date.forward(23)
    )

    rand(6).times do
      Comment.create!(
        description: Faker::Lorem.paragraph,
        task_id: task.id,
        user_id: User.all.sample.id
      )
    end
  end

  users = User.all
  rand(15).times do
    user = users.sample
    member = Membership.new(
      user_id: user.id,
      project_id: project.id,
      role: ["Member", "Owner"].sample,
    )
    if member.save
    end
  end
end
