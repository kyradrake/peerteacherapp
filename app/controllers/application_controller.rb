class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :authenticate_admin!
  
  def authenticate_admin!
    :authenticate_user unless current_user.try( :admin? )
  end
  
end
