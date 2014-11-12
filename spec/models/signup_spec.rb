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

end
