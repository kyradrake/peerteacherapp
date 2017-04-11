require 'rails_helper'

RSpec.describe "peer_teacher_logins/edit", type: :view do
  before(:each) do
    @peer_teacher_login = assign(:peer_teacher_login, PeerTeacherLogin.create!(
      :first_name => "MyString",
      :last_name => "MyString"
    ))
  end

  it "renders the edit peer_teacher_login form" do
    render

    assert_select "form[action=?][method=?]", peer_teacher_login_path(@peer_teacher_login), "post" do

      assert_select "input#peer_teacher_login_first_name[name=?]", "peer_teacher_login[first_name]"

      assert_select "input#peer_teacher_login_last_name[name=?]", "peer_teacher_login[last_name]"
    end
  end
end
