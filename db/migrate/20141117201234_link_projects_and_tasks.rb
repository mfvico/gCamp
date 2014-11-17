class LinkProjectsAndTasks < ActiveRecord::Migration
  def change
    change_table :tasks do |t|
  t.belongs_to :project  # <= will produce an integer column called project_id
end
  end
end
