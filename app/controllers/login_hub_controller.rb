class LoginHubController < PeerTeacherController
  before_action :authenticate_user!
  #will be displayed in the /login_hub/index 
  def index
    #byebug
    @parent_user = current_user   #assign the login attributes to the parent_user instance 
    @user = PeerTeacherLogin.find( current_user.meta_id )
    
    @office_hours = OfficeHour.all
    @peer_teachers = PeerTeacher.all
    @updates = Update.all
    @time = Time.new
    @today = (@time.month.to_s + "/" + @time.day.to_s + "/" + @time.year.to_s)
    puts "********#{request.remote_ip}: logged into peer teacher hub using email: #{@user.first_name} "
  end
  
end
