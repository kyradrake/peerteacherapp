class LoginHubController < ApplicationController
  before_action :authenticate_user!
  
  def index
    if user_signed_in? 
      @user_name = "#{current_user.first_name}  #{current_user.last_name}"
    elsif current_user.try(:admin?)
      puts "Admin Working"
    end
  end
  
  
end
