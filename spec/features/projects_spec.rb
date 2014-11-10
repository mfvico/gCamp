require 'rails_helper'

feature "Projects" do

  scenario "User can create projects" do
    visit projects_path
    click_on "New Project"
    fill_in "Name", with: "Tester"
    click_on "Create Project"
    expect(page).to have_content("Tester")
    click_on "back"
    expect(page).to have_content("Tester")
  end

  def create_project
    Project.create!(
    name: "Tester"
    )
  end

  scenario "User can show and edit projects" do
    create_project
    visit projects_path
    click_on "Tester"
    click_on "Edit"
    fill_in "Name", with: "Not tester"
    click_on "Update Project"
    expect(page).to have_content("Not tester")
  end

  scenario "User can delete projects" do
    create_project
    visit projects_path
    click_on "Tester"
    click_on "Delete"
    expect(page).to have_no_content("Tester")
  end

  scenario "User cannot make a project without a name" do
    visit projects_path
    click_on "New Project"
    click_on "Create Project"
    expect(page).to have_content("Name can't be blank")
  end

end
