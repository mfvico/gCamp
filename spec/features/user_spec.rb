require 'rails_helper'

feature "Users" do

  scenario "Users can be added" do
    visit users_path
    click_on "Create User"
    fill_in "First name", with: "Busta"
    fill_in "Last name", with: "Rhymes"
    fill_in "Email", with: "flip@mode.com"
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "test"
    click_on "Create User"
    expect(page).to have_content("Busta Rhymes")
    expect(page).to have_content("flip@mode.com")
  end

  def create_user
    User.create!(
      first_name: "Tech",
      last_name: "N9ne",
      email: "flip@mode.com",
      password: "test",
      password_confirmation: "test"
    )
  end

  scenario "Users can be edited" do
    create_user
    visit users_path
    click_on "Edit"
    fill_in "Email", with: "strange@music.com"
    fill_in "First name", with: "Busta"
    fill_in "Last name", with: "Rhymes"
    click_on "Update User"
    expect(page).to have_content("strange@music.com")
    expect(page).to have_content("Busta Rhymes")
  end

  scenario "Users can be destroyed" do
    create_user
    visit users_path
    click_on "Edit"
    click_on "Delete User"
    expect(page).to have_no_content("Tech N9ne")
  end

  scenario "Users cannot be created without name or email" do
    visit users_path
    click_on "Create User"
    click_on "Create User"
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
    expect(page).to have_content("Email can't be blank")
  end

end
