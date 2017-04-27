class User < ActiveRecord::Base
  #rolify
  devise :database_authenticatable, :lockable,
         :recoverable, :trackable, :registerable
  
  belongs_to :meta, polymorphic: true

end
