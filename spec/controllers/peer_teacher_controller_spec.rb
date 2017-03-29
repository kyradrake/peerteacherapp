require 'rails_helper'
require '/home/ubuntu/workspace/app/models/peer_teacher.rb'
require '/home/ubuntu/workspace/app/controllers/peer_teacher_controller.rb'

#require 'peer_teacher_controller.rb'
# require '/Users/Alan/Downloads/workspace/app/controllers/peer_teacher_controller.rb'

RSpec.describe PeerTeacherController, :type => :controller do
  #pending "add some examples to (or delete) #{__FILE__}"
    describe 'not_to raise_error' do
    	#get index
        it "should be defined" do
            expect{PeerTeacherController}.not_to raise_error
        end

        before(:each)  { @peerteacher = PeerTeacherController.new() }
        
       # it "should have defined index function" do
        #  expect{PeerTeacherController.index}.not_to raise_error
        #end
        
        describe '#test function'
        it "should be defined" do
        	expect{ @peerteacher.func}.not_to raise_error
        end
        
    end
end