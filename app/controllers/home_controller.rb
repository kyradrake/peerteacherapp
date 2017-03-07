class HomeController < PeerTeacherController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def sign_out_user 
    if user_signed_in? 
      destroy_user_session_path 
      puts "Working"
    end 
  end
end