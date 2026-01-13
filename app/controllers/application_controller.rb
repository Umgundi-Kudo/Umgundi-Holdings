class ApplicationController < ActionController::Base
  helper_method :current_user

  private

  def require_login
    redirect_to login_path unless current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
