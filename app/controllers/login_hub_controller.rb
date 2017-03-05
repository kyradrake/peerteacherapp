class LoginHubController < ApplicationController
  before_action :authenticate_user!
  
  def index
    if user_signed_in? 
      puts "Hello #{current_user.first_name}"
    else
      redirect_to home_index_path  
    end
  end
  
  def admin 
    puts "Admin is working"
  end
  
end
