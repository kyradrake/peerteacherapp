class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
   protect_from_forgery with: :exception
  
  before_action :require_login 
  helper_method :sign_user_off
  
  private
  def require_login   #login will go here because of before_action 
    unless user_signed_in? 
      flash[:error] = "Invalid email or password"
      byebug
      redirect_to root_path
    end
  end
  
  def is_admin?
    if current_user.admin 
      return true
    else
      return false 
    end
  end

  def authenticate_admin!
    redirect_to new_user_session_path unless current_user.admin?
  end

end
