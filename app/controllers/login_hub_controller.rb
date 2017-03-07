class LoginHubController < ApplicationController
  before_action :authenticate_user!
  #will be displayed in the /login_hub/index 
  def index
    puts current_user.email 
  end
end
