class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :determine_layout

  class AccessDenied < StandardError

  end

  rescue_from AccessDenied, with: :render_404

  def render_404
    render "public/404", status: :not_found, layout: false
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  helper_method :current_user

  private

  def not_logged_in
    unless current_user
      redirect_to signin_path
      flash[:alert] = "You must be logged to access that action"
    end
  end

  def determine_layout
    current_user ? "application" : "public"
  end



end
