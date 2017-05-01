class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :require_login
  before_action :configure_permitted_parameters, if: :devise_controller? 
  helper_method :sign_user_off
  
  def configure_permitted_parameters 
    update_attrs = [:password, :password_confirmation, :current_password]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs 
  end
  
  def authenticate_admin!
    redirect_to new_user_session_path unless current_user.meta_type == "Administrator"
  end

  private
  
   def require_login   #login will go here because of before_action
    if !user_signed_in?          #if the user IS NOT signed in
      flash[:error] = "You must login before proceeding"
      redirect_to root_path
    end
  end
  
  def after_sign_in_path_for
    #byebug
    if current_user.sign_in_count == 1 
      redirect_to edit_user_registration_path 
    end
  end
  
  def sign_user_off
    if user_signed_in? 
      destroy_user_session_path
    end
  end
  
  def after_sign_out_path_for(resource)
    request.referrer || root_path
  end
  
end
