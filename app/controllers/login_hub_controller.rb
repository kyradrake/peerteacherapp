class LoginHubController < PeerTeacherController
  before_action :authenticate_user!
  #will be displayed in the /login_hub/index 
  def index
    @user = PeerTeacherLogin.find( current_user.meta_id );
    @office_hours = OfficeHour.all
    @peer_teachers = PeerTeacher.all
    @updates = Update.all
    @time = Time.new
    @today = (@time.month.to_s + "/" + @time.day.to_s + "/" + @time.year.to_s)
    puts "********#{request.remote_ip}: logged into peer teacher hub using email: #{current_user.email} "
  end
  
end
