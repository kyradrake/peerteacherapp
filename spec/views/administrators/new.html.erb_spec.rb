require 'rails_helper'

RSpec.describe "administrators/new", type: :view do
  before(:each) do
    assign(:administrator, Administrator.new(
      :first_name => "MyString",
      :last_name => "MyString"
    ))
  end

  it "renders new administrator form" do
    render

    assert_select "form[action=?][method=?]", administrators_path, "post" do

      assert_select "input#administrator_first_name[name=?]", "administrator[first_name]"

      assert_select "input#administrator_last_name[name=?]", "administrator[last_name]"
    end
  end
end
