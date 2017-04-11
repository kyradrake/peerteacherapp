class User < ActiveRecord::Base
  rolify
  devise :database_authenticatable, :lockable,
         :recoverable, :trackable
  belongs_to :meta, polymorphic: true 
end
