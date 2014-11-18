class MembershipsController < ApplicationController
  before_action do
    @project = Project.find(params[:project_id])
  end
  def index
    @membership = @project.memberships.new
  end

end
