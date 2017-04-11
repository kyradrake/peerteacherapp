class PeerTeacherLogin < ActiveRecord::Base
    has_one :user, as: :meta, dependent: :destroy 
    accepts_nested_attributes_for :user
    
    validates :first_name, presence: true
    validates :last_name, presence: true 
end
