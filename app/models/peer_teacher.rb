class PeerTeacher < ActiveRecord::Base
    def peerTeacher_params
        params.require(:peerTeachers).permit(:email, :name, :courselist, :timelist)
    end
    	
    # def self.search(search)
    #     where("name LIKE ?", "%#{search}%") 
    #     where("content LIKE ?", "%#{search}%")
    # end
    
    
end
