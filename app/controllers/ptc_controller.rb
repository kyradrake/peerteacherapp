class PtcController < PeerTeacherController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  skip_before_action :require_login, only: [:index, :ptc]
  
  def ptc
    @peer_teachers = PeerTeacher.all
    @office_hours = OfficeHour.all
    @time = Time.new
  end
end