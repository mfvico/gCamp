namespace :comment do
  desc "Remove invalid/orphaned comments from tasks"
  task remove: :environment do
    p Comment.where.not(task_id: Task.pluck(:id))
    Comment.where.not(task_id: Task.pluck(:id)).destroy_all
  end
end
