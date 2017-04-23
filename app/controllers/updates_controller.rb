class UpdatesController < ApplicationController
    
    skip_before_action :require_login, only: [:edit, :index]
    
    def index 
        redirect_to login_hub_index_path 
    end
    
    def edit
        @updates = Update.all
        disapproved = @updates.find_by timeID: params[:id]
        
        if (disapproved.approved == 1)
            ExampleMailer.api_email(disapproved.email, false, params[:id]).deliver_later
        end
        
        disapproved.update(approved: 0)
    end
    
    def destroy
        @update = Update.find(params[:id])
        @update.destroy
        flash[:notice] = "Update deleted."
        redirect_to login_hub_index_path
    end
    
end
