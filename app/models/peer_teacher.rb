class PeerTeacher < ActiveRecord::Base
    def peerTeacher_params
        params.require(:peerTeachers).permit(:email, :name, :courselist, :timelist)
    end
end
