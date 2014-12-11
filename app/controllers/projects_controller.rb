class ProjectsController < ApplicationController

  before_action :not_logged_in
  before_action :set_project, only: [:edit, :update, :destroy, :show]
  before_action :authorize_owner, only: [:edit, :update, :destroy]

  def index
    @projects = Project.all
    tracker_api = TrackerAPI.new
    @tracker_projects = tracker_api.projects(current_user.tracker_token)
  end

  def new
    @project = Project.new
    @new_project = true
  end

  def create
    project_params = params.require(:project).permit(:name)
    @project = Project.new(project_params)
    @owner = @project.memberships.new(
      project_id: @project.id,
      user_id: current_user.id,
      role: "owner")
    if @project.save
      @owner.save
      flash[:notice] = "Project was successfully created"
      redirect_to project_tasks_path(@project)
    else
      render :new
    end
  end

  def show
  end

  def edit
    @project = Project.find(params[:id])

    @edit_project = true
  end

  def update
    if owner_check || admin_check
      project_params = params.require(:project).permit(:name)
      if @project.update(project_params)
        flash[:notice] = "Project was successfully updated"
        redirect_to project_path(@project)
      else
        render :edit
      end
    end
  end

  def destroy
    if owner_check || admin_check
      @project.destroy
      flash[:notice] = "Project was successfully destroyed"
      redirect_to projects_path
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def authorize_owner
    unless current_user.memberships.where(project_id: @project.id, role: "owner").exists? || admin_check
      raise AccessDenied
    end
  end

  def authorize_member
    unless current_user.projects.include?(@project)
      raise AccessDenied
    end
  end

  def owner_check
    current_user.memberships.where(project_id: @project.id, role: "owner")
  end

end
