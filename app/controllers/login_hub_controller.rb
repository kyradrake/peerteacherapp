class LoginHubController < ApplicationController
  before_action :authenticate_user!
  #will be displayed in the /login_hub/index 
  def index
    puts "TESTING TESTING TESTING "
    puts current_user.email 
  end
  def admin
    puts "Admin Page"
  end
end
