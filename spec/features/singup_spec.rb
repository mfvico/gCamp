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

  end

  def create_user
      User.create!(
        first_name: 'Busta',
        last_name: 'Rhymes',
        email: 'flip@mode.com',
        password: 'test',
        password_confirmation: 'test'
      )

  end

  def signout
    click_on "Sign Out"
    expect(page).to have_no_content("Busta Rhymes")
  end
  scenario "Users can sign in" do
    create_user
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "flip@mode.com"
    fill_in "Password", with: "test"
    click_on "Sign in"
    expect(page).to have_content("Busta Rhymes")

  end

  scenario "Users can sign out" do
    create_user
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "flip@mode.com"
    fill_in "Password", with: "test"
    click_on "Sign in"
    expect(page).to have_content("Busta Rhymes")
    signout
  end

  scenario "User inputs invalid username/password" do
    create_user
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "flip@modee.com"
    fill_in "Password", with: "test"
    click_on "Sign in"
    expect(page).to have_content("Username / password combination is invalid")
    fill_in "Email", with: "flip@mode.com"
    click_on "Sign in"
    expect(page).to have_content("Username / password combination is invalid")
  end

  scenario "User inputs invalid signup credentials" do
    visit root_path
    click_on "Sign Up"
    fill_in "First name", with: "Tes"
    fill_in "Last name", with: "Ter"
    fill_in "Email", with: "flipmode@strange.com"
    fill_in "Password", with: "test"
    fill_in "Password confirmation", with: "tesst"
    click_on "Sign up"
    expect(page).to have_content("Password confirmation doesn't match Password")
    click_on "Sign up"
    expect(page).to have_content("Password can't be blank")
  end
  scenario "User does not input any info for signup" do
    visit root_path
    click_on "Sign Up"
    click_on "Sign up"
    expect(page).to have_content("Password can't be blank")
    expect(page).to have_content("Email can't be blank")
  end

end
