class MembershipsController < ApplicationController
  before_action do
    @project = Project.find(params[:project_id])
  end

  def index
    @membership = @project.memberships.new
    @memberships = @project.memberships.all
  end

  def create
    membership_params = params.require(:membership).permit(
      :user_id, :role
    )
    @membership = @project.memberships.new(membership_params)
    if @membership.save
      redirect_to project_memberships_path(@project),
      notice: "#{@membership.user.full_name} was successfully added!"
    else
      render :index
    end
  end

  def update
    membership_params = params.require(:membership).permit(
      :user_id, :role
    )
    @membership = @project.memberships.find(params[:id])
    if @membership.update(membership_params)
      redirect_to project_memberships_path(@project),
      notice: "#{@membership.user.full_name} was successfully updated!"
    else
      render :index
    end
  end

  def destroy
    @membership = @project.memberships.find(params[:id])
    @membership.destroy
    redirect_to project_memberships_path(@project), 
    notice: "#{@membership.user.full_name} was successfully removed"
  end

end
