class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception



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

end
