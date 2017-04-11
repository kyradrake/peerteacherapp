require "rails_helper"

RSpec.describe PeerTeacherLoginsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/peer_teacher_logins").to route_to("peer_teacher_logins#index")
    end

    it "routes to #new" do
      expect(:get => "/peer_teacher_logins/new").to route_to("peer_teacher_logins#new")
    end

    it "routes to #show" do
      expect(:get => "/peer_teacher_logins/1").to route_to("peer_teacher_logins#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/peer_teacher_logins/1/edit").to route_to("peer_teacher_logins#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/peer_teacher_logins").to route_to("peer_teacher_logins#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/peer_teacher_logins/1").to route_to("peer_teacher_logins#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/peer_teacher_logins/1").to route_to("peer_teacher_logins#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/peer_teacher_logins/1").to route_to("peer_teacher_logins#destroy", :id => "1")
    end

  end
end
