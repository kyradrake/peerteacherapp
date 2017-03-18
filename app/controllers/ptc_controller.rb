class PtcController < PeerTeacherController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def ptc
    @peer_teachers = PeerTeacher.all
    @office_hours = OfficeHour.all
  end
end