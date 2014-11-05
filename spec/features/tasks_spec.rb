require 'rails_helper'

feature "Tasks" do

  scenario "User can create Tasks" do
    visit root_path
    click_on "Tasks"
    click_on "Create Task"
    fill_in "Task", with: "Test Task"
    fill_in "Due date", with: "2014/11/11"
    click_on "Create Task"
    expect(page).to have_content("Test Task")
    save_and_open_page
  end

  def create_task
    Task.create!(
      task: "testy test",
      due_date: "2014/11/11"
    )
  end

  scenario "User can edit Tasks" do
    create_task
    visit tasks_path
    click_on "Edit"
    save_and_open_page
    fill_in "Task", with: "non testy test"
    fill_in "Due date", with: "2014/11/25"
    check('Complete')
    click_on "Update Task"
    expect(page).to have_content("non testy test")
    save_and_open_page
  end

  scenario "User can show Tasks" do
    create_task
    visit tasks_path
    click_on "Show"
    expect(page).to have_content("testy test")
  end

  scenario "User can destroy Tasks" do
    create_task
    visit tasks_path
    click_on "Destroy"
    expect(page).to have_no_content("testy test")
  end

end
