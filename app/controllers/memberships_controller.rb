class MembershipsController < ApplicationController

  before_action do
    @project = Project.find(params[:project_id])
  end
  before_action :member_check

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

  private

  def member_check
    unless current_user.memberships.where(project_id: @project.id).exists?
        raise AccessDenied
    end
  end

end
