require 'rails_helper'

RSpec.describe "peer_teacher_logins/index", type: :view do
  before(:each) do
    assign(:peer_teacher_logins, [
      PeerTeacherLogin.create!(
        :first_name => "First Name",
        :last_name => "Last Name"
      ),
      PeerTeacherLogin.create!(
        :first_name => "First Name",
        :last_name => "Last Name"
      )
    ])
  end

  it "renders a list of peer_teacher_logins" do
    render
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
  end
end
