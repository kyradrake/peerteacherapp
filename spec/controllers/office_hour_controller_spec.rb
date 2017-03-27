require 'rails_helper'
require '/home/ubuntu/workspace/app/controllers/office_hour_controller.rb'

RSpec.describe OfficeHourController, type: :controller do
    describe "#sum" do
        it "should be defined" do
            expect { sum }.not_to raise_error
        end
    end
end
