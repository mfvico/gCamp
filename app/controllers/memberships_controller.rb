class MembershipsController < ApplicationController

  before_action do
    @project = Project.find(params[:project_id])
  end
  before_action :member_check
  before_action :owner_check

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
    if owner_check || admin_check
      if @membership.update(membership_params)
        redirect_to project_memberships_path(@project),
        notice: "#{@membership.user.full_name} was successfully updated!"
      else
        render :index
      end
    end
  end

  def destroy
    @membership = @project.memberships.find(params[:id])
    if owner_check || current_user.id == @membership.user_id || admin_check
      @membership.destroy
      redirect_to project_memberships_path(@project),
      notice: "#{@membership.user.full_name} was successfully removed"
    end
  end

  private

  def member_check
    unless current_user.memberships.where(project_id: @project.id).exists? || current_user.admin
      raise AccessDenied
    end
  end

  def owner_check
    current_user.memberships.where(project_id: @project.id, role: "owner").exists?
  end


end
