require 'rails_helper'

feature "Membership" do

  def create_user
    User.create!(
      first_name: "Vico",
      last_name: "Mello",
      email: "not@you.com",
      password: "whoop",
      password_confirmation: "whoop"
    )
  end

  def create_project
    Project.create!(
      name: "My Project"
    )
  end

  def add_member
    visit projects_path
    click_on "My Project"
    click_on "0 users"
    select "Vico Mello", :from => "membership[user_id]"
    click_on "Create Membership"
  end

  scenario "Members can be added to Project" do
    create_user
    create_project
    add_member
    expect(page).to have_content("Vico Mello")
  end


end
