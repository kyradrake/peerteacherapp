require 'rails_helper'

RSpec.describe "administrators/edit", type: :view do
  before(:each) do
    @administrator = assign(:administrator, Administrator.create!(
      :first_name => "MyString",
      :last_name => "MyString"
    ))
  end

  it "renders the edit administrator form" do
    render

    assert_select "form[action=?][method=?]", administrator_path(@administrator), "post" do

      assert_select "input#administrator_first_name[name=?]", "administrator[first_name]"

      assert_select "input#administrator_last_name[name=?]", "administrator[last_name]"
    end
  end
end
