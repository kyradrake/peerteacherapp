class UpdatesController < ApplicationController
    
    skip_before_action :require_login, only: [:edit, :index]
    
    def index 
        
    end
    
    def edit
        @updates = Update.all
        disapproved = @updates.find_by (timeID : params[:id])
        disapproved.update(approved: 0)
        session[:iddd] = disaproved.approved
    end
    
end
