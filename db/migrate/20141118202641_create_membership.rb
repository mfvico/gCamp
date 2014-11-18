class CreateMembership < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.belongs_to :project
      t.belongs_to :user
    end
  end
end
