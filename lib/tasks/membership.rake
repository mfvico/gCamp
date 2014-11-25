namespace :membership do
  desc "Removes invalid/orphaned memberships from Projects"
  task remove: :environment do
    p Membership.where.not(user_id: User.pluck(:id))
    Membership.where.not(user_id: User.pluck(:id)).destroy_all
    Membership.where.not(project_id: Project.pluck(:id)).destroy_all
  end
end
