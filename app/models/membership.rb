class Membership < ActiveRecord::Base

  validates :user, uniqueness: {scope: :project, message: "has already been added"}
  validates_presence_of :user

  belongs_to :project
  belongs_to :user

end
