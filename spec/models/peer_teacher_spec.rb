require 'rails_helper'
#require 'app/controllers/peer_teacher_controller.rb'

RSpec.describe PeerTeacher, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
    describe '#peerTeacher_params' do
        it "should be defined" do
            expect { peerTeacher_params }.not_to raise_error
        end
    end
end