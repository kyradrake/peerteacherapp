class User::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
   def new
     puts "WOrking with correct RegistrationsController" 
     super
   end

  # POST /resource
   def create
     puts "WOrking with correct RegistrationsController" 
     super
   end

  # GET /resource/edit
   def edit
     puts "WOrking with correct RegistrationsController" 
     super
   end

  # PUT /resource
    def update
        #puts "WOrking with correct RegistrationsController" 
        #super
        @user = User.find( current_user.id )
        if @user.update( user_params )
            bypass_sign_in( @user )
            redirect_to root_path 
        else
            render "edit"
        end
    end

  # DELETE /resource
   def destroy
     puts "WOrking with correct RegistrationsController" 
     super
   end

  private 
  # If you have extra params to permit, append them to the sanitizer.
   
    def user_params 
       params.require( :user ).permit(:password, :password_confirmation) 
    end
   
    def configure_sign_up_params
      puts "WOrking with correct RegistrationsController" 
      devise_parameter_sanitizer.permit(:id, :email, :password, :sign_up, :meta_id, keys: [:attribute])
    end

  # If you have extra params to permit, append them to the sanitizer.
    def configure_account_update_params
        puts "WOrking with correct RegistrationsController" 
        devise_parameter_sanitizer.permit(:id, :email, :password, :account_update, :meta_id, keys: [:attribute])
    end

  # The path used after sign up.
    #def after_sign_up_path_for(resource)
    #    puts "WOrking with correct RegistrationsController" 
    #    super(resource)
    #end

  # The path used after sign up for inactive accounts.
    #def after_inactive_sign_up_path_for(resource)
        #puts "WOrking with correct RegistrationsController" 
        #super(resource)
    #end
end
