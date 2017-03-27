class LoginHubController < PeerTeacherController
  before_action :authenticate_user!
  #will be displayed in the /login_hub/index 
  def index
    @office_hours = OfficeHour.all
    @peer_teachers = PeerTeacher.all
    puts "TESTING TESTING TESTING "
    puts current_user.email 
  end
  def admin
    puts "Admin Page"
  end
end
