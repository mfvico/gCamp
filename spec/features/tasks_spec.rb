require 'rails_helper'

include ObjectCreationMethods

feature "Tasks" do


  scenario "User can create Tasks" do
    user = create_user
    project = create_project
    create_membership(user: user, project: project)
    visit projects_path
    click_on "#{project.name}"
    click_on "0 Tasks"
    click_on "Create Task"
    fill_in "Task", with: "Test Task"
    fill_in "Due date", with: "2017/11/11"
    click_on "Create Task"
    expect(page).to have_content("Test Task")
  end

  def create_task
    click_on "0 Tasks"
    click_on "Create Task"
    fill_in "Task", with: "Test Task"
    fill_in "Due date", with: "2017/11/11"
    click_on "Create Task"
  end

  scenario "User can edit Tasks" do
    create_project

    visit projects_path
    click_on "Tester"
    create_task
    click_on "Edit"
    fill_in "Task", with: "non testy test"
    fill_in "Due date", with: "12/5/2015"
    check('Complete')
    click_on "Update Task"
    expect(page).to have_content("non testy test")
    expect(page).to have_content("December 5, 2015")
  end

  scenario "User can show Tasks" do
    create_project
    visit projects_path
    click_on "Tester"
    create_task

    expect(page).to have_content("Test Task")
  end

  # scenario "User can destroy Tasks" do
  #   create_project
  #   visit projects_path
  #   click_on "Tester"
  #   create_task
  #   click_on "Tester"
  #   click_on ""
  #   expect(page).to have_no_content("testy test")
  # end

  scenario "User cannot submit task without description" do
    create_project
    visit projects_path
    click_on "Tester"
    click_on "0 Tasks"
    click_on "Create Task"
    click_on "Create Task"
    expect(page).to have_content("Task can't be blank")
  end

  scenario "User cannot submit task with past due date" do
    create_project
    visit projects_path
    click_on "Tester"
    click_on "0 Tasks"
    click_on "Create Task"
    fill_in "Due date", with: "11/1/2014"
    fill_in "Task", with: "11/1/2014"
    click_on "Create Task"
    expect(page).to have_content("Due date cannot be in the past")
  end

end
