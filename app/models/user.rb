class User < ActiveRecord::Base

  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true

  before_save { self.email = email.downcase }
  has_secure_password

end
