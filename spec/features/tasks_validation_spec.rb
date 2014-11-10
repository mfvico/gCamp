require 'rails_helper'

feature "Tasks Validation" do

  scenario "User cannot submit task without description" do
    visit tasks_path
    click_on "Create Task"
    click_on "Create Task"
    expect(page).to have_content("Task can't be blank")
  end

end
