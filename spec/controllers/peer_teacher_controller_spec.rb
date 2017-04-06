# Rails.logger.debug variable.inspect
# Rails.logger.debug variable.to_yaml


require 'rails_helper'

require 'pp'
#require 'spec_helper'
#require '/home/ubuntu/workspace/app/models/peer_teacher.rb'
#require '/home/ubuntu/workspace/app/controllers/peer_teacher_controller.rb'
#require 'peer_teacher_helper'
#require 'peer_teacher_controller.rb'
# require '/Users/Alan/Downloads/workspace/app/controllers/peer_teacher_controller.rb'

RSpec.describe PeerTeacherController, :type => :controller do
  #pending "add some examples to (or delete) #{__FILE__}"
    describe 'Testing Controller' do
    	#get index
        it "should be defined" do
            expect{PeerTeacherController}.not_to raise_error
        end

        before :each do
            @peer_teacher = PeerTeacherController.new()
            @peer_teacher.extend(PeerTeacherHelper)
            #@office_hours = OfficeHour.all() 
        end
        
        it "should have defined func function" do
            controller.func(1000).should == 1000
        end
        
        it "returns http success" do
            if session[:available_pts].present?
                get :index
                expect(response).to have_http_status(:success)
            # else
            #     @pt=PeerTeacher.create :name => "a", :email => "testemail@gmail.com"
            #     current_user = @pt
            #     session[:available_pts] = @pt.id
            #     get :index
            #     expect(response).to have_http_status(:redirect)
            end
            
        end
        
        	#describe "It renders templates" do
		it "should render the index template" do
			get :index
			expect(response).to render_template("index")
		end
        
        # subject { get :populate_db}
        
        # it "should render template" do
        #     expect(subject).to render_template(:populate_db)
        # end

        
        # it "returns http redirect" do
        #     if !session[:available_pts].present?
        #         get :index
        #         expect(response).to have_http_status(:success)
        #     end
        # end

        
    end
end