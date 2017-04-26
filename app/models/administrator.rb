class Administrator < ActiveRecord::Base
    has_one :user, as: :meta, dependent: :destroy 
    accepts_nested_attributes_for :user, allow_destroy: true 
    
    
end
