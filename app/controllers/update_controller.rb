class UpdatesController < ApplicationController
    
    
    skip_before_action :require_login, only: [:edit]
    
    #edit page is just going to display the id for now
    #for example, https://peerteacherapp2-k4sr4.c9users.io/updates/100/edit should display "100"
    # it doesn't matter if it is under the edit link, it can be under any other CRUD. I just need to opena a page for updates
    
    def index 
        
    end
    
    def edit
        id = params[:id]
        session[:iddd] = id
    end
    
end
