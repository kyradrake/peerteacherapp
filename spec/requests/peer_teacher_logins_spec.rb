require 'rails_helper'

RSpec.describe "PeerTeacherLogins", type: :request do
  describe "GET /peer_teacher_logins" do
    it "works! (now write some real specs)" do
      get peer_teacher_logins_path
      expect(response).to have_http_status(200)
    end
  end
end
