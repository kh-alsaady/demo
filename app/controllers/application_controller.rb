class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?, :admin?
  
  def current_user
    @current_user ||= User.includes([{accounts: :type}, :role, {courses: :category}]).find_by_id(session[:user_id])
  end
  
  def logged_in?
    current_user != nil
  end
  
  def admin?
    current_user.role && current_user.role.name == 'admin' 
  end
  
end
