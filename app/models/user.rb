class User < ActiveRecord::Base

  def full_name
    "#{first_name} #{last_name}"
  end


  before_save { self.email = email.downcase }
  validates :email, presence: true, :uniqueness => { :case_sensitive => false }
  validates :first_name, :last_name, presence: true



  has_secure_password

  has_many :memberships, dependent: :destroy
  has_many :comments, dependent: :nullify
  has_many :projects, through: :memberships



end
