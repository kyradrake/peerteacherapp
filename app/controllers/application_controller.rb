class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :require_login 
  before_action :store_current_location, :unless => :devise_controller?
  helper_method :sign_user_off
  
  private
   def require_login   #login will go here because of before_action
    if !user_signed_in?          #if the user IS NOT signed in 
      redirect_to root_path
    end
  end
  
  def authenticate_admin?
      if current_user.meta_type == "Administrator"
        return true
      else
        return false
      end
  end
  
  def authenticate_admin!
    redirect_to new_user_session_path unless current_user.meta_type == "Administrator"
  end
  
  def sign_user_off
    if user_signed_in? 
      destroy_user_session_path
    end
  end
  
  def store_current_location
    store_location_for(:user, request.url)
  end
  
  def after_sign_out_path_for(resource)
    request.referrer || root_path
  end
  
end
