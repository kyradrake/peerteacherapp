require 'rails_helper'

RSpec.describe "peer_teacher_logins/show", type: :view do
  before(:each) do
    @peer_teacher_login = assign(:peer_teacher_login, PeerTeacherLogin.create!(
      :first_name => "First Name",
      :last_name => "Last Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
  end
end
