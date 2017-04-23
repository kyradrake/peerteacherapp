class Administrator < ActiveRecord::Base
    has_one :user, as: :meta, dependent: :destroy 
    accepts_nested_attributes_for :user 
    
    validates :first_name, presence: true
    validates :last_name, presence: true
    
    
    private 
        def set_administrator
           @administrator = Administrator.find( params[:id]) 
        end
        
        def administrator_params
           params[:administrator].permit( :first_name, :last_name, user_attributes: [ :email, :password ] ) 
        end
end
