class CreateCommentsTable < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :task
      t.string :description
      t.timestamp
    end
  end
end
