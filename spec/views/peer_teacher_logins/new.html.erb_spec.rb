require 'rails_helper'

RSpec.describe "peer_teacher_logins/new", type: :view do
  before(:each) do
    assign(:peer_teacher_login, PeerTeacherLogin.new(
      :first_name => "MyString",
      :last_name => "MyString"
    ))
  end

  it "renders new peer_teacher_login form" do
    render

    assert_select "form[action=?][method=?]", peer_teacher_logins_path, "post" do

      assert_select "input#peer_teacher_login_first_name[name=?]", "peer_teacher_login[first_name]"

      assert_select "input#peer_teacher_login_last_name[name=?]", "peer_teacher_login[last_name]"
    end
  end
end
