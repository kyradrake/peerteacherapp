


require 'rails_helper'
# require '/home/ubuntu/workspace/app/models/peer_teacher.rb'
#load 'app/controllers/peer_teacher_controller.rb'

RSpec.describe PeerTeacherController, type: :controller do
  #pending "add some examples to (or delete) #{__FILE__}"
    describe '#index' do
        it "should be defined" do
            expect { index }.not_to raise_error
        end
    end
end