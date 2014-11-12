require 'rails_helper'

describe User do

  it 'verifies entry of all fields' do
    user = User.new
    user.valid?
    expect(user.errors.present?).to eq(true)
    user.first_name = 'Jim'
    user.valid?
    expect(user.errors.present?).to eq(true)
    user.last_name = 'Gaffigan'
    user.valid?
    expect(user.errors.present?).to eq(true)
    user.email = "jim@jim.com"
    user.valid?
    expect(user.errors.present?).to eq(true)
    user.password = "test"
    user.password_confirmation = "test"
    user.valid?
    expect(user.errors.present?).to eq(false)
  end

  it 'verifies that password and confirmation must match' do
    user = User.new
    user.first_name = 'User'
    user.last_name = 'User'
    user.email = 'user@example.com'
    user.password = 'password'
    user.password_confirmation = 'another_password'
    expect(user.valid?).to be(false)
    user.password_confirmation = 'password'
    expect(user.valid?).to be(true)
  end

  it 'verifies the uniqueness of the email address' do
    User.create!(
      first_name: "Fred",
      last_name: "Flintstone",
      email: "fred@rockmail.com",
      password: "test",
      password_confirmation: "test"
      )
    user = User.new(
    first_name: "Rob",
    last_name: "Swanson",
    email: "fred@rockmail.com",
    password: "test",
    password_confirmation: "test"
    )
    user.valid?
    expect(user.errors[:email].present?).to eq(true)
    user.email="rob@rockmail.com"
    user.valid?
    expect(user.errors.present?).to eq(false)
  end

end
