require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the PeerTeacherHelper. For example:
#
# describe PeerTeacherHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe PeerTeacherHelper, type: :helper do
  #pending "add some examples to (or delete) #{__FILE__}"
    describe 'Testing Module' do
        
        before :each do
            @peer_teacher = PeerTeacherController.new()
            @peer_teacher.extend(PeerTeacherHelper)
            #@office_hours = OfficeHour.all() 
        end
        
        it "should have working beautify_time" do
            oh1 = OfficeHour.create(:timeID => 176, :email => "dhananjay@tamu.edu", :dow => "W", :sHour => 10, :sMin => 10, :eHour => 11, :eMin => 40, :change => "No Change")
            oh2 = OfficeHour.create(:timeID => 182, :email => "dhananjay@tamu.edu", :dow => "MWF", :sHour => 22, :sMin => 10, :eHour => 23, :eMin => 40, :change => "No Change")
            oh3 = OfficeHour.create(:timeID => 101, :email => "dhananjay@tamu.edu", :dow => "TR", :sHour => 10, :sMin => 10, :eHour => 13, :eMin => 40, :change => "No Change")
            oh4 = OfficeHour.create(:timeID => 201, :email => "dhananjay@tamu.edu", :dow => "TW", :sHour => 00, :sMin => 00, :eHour => 12, :eMin => 00, :change => "No Change")

            expect(@peer_teacher.beautify_time(oh1)).to eql [10,10,"am",11,40,"am"]
            expect(@peer_teacher.beautify_time(oh2)).to eql [10,10,"pm",11,40,"pm"]
            expect(@peer_teacher.beautify_time(oh3)).to eql [10,10,"am",1,40,"pm"]
            expect(@peer_teacher.beautify_time(oh4)).to eql [0,"00","am",12,"00","pm"]
        end
        
        it "should have working format_message" do
            string1 = "Kasra is a beautiful, wonderful genius"
            string2 = "One potato, Two potato, Three potato, Four!"
            string3 = ""
        
            expect(@peer_teacher.format_message(string1)).to eql ["Kasra is a beautiful, \n", "wonderful genius"]
            expect(@peer_teacher.format_message(string2)).to eql ["One potato, Two potato\n", ", Three potato, Four!"]
            expect(@peer_teacher.format_message(string3)).to eql [""]
        end
    end
end
