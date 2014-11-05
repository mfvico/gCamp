require 'rails_helper'

feature "Signup" do

  scenario "User can sign up" do

    visit root_path
    click_on "Sign Up"
    fill_in "First name", with: "Happy"
    fill_in "Last name", with: "Gilmore"
    fill_in "Email", with: "e@mail.com"
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "test"
    click_on "Sign up"
    expect(page).to have_content("Happy Gilmore")
    save_and_open_page

  end

  def signin
      User.create!(
        first_name: 'Busta',
        last_name: 'Rhymes',
        email: 'flip@mode.com',
        password: 'test',
        password_confirmation: 'test'
      )
      visit root_path
      click_on "Sign In"
      fill_in "Email", with: "flip@mode.com"
      fill_in "Password", with: "test"
      click_on "Sign in"
      expect(page).to have_content("Busta Rhymes")
      save_and_open_page

  end

  def signout
    click_on "Sign Out"
    expect(page).to have_no_content("Busta Rhymes")
    save_and_open_page
  end
  scenario "Users can sign in" do
    signin
  end

  scenario "Users can sign out" do
    signin
    signout
  end

end
