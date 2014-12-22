class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :not_logged_in



  class AccessDenied < StandardError

  end

  rescue_from AccessDenied, with: :render_404

  def render_404
    render "public/404", status: :not_found, layout: false
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  helper_method :current_user
  helper_method :admin_check
  helper_method :authorize_owner
  helper_method :authorize_member
  helper_method :owner_check

  private

  def not_logged_in
    unless current_user
      store_location
      redirect_to signin_path
      flash[:alert] = "You must be logged to access that action"
    end
  end

  def admin_check
    current_user.admin
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
