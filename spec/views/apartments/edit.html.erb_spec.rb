require 'rails_helper'

RSpec.describe "apartments/edit", type: :view do
  before(:each) do
    @apartment = assign(:apartment, Apartment.create!(
      :address => "MyString",
      :name => "MyString",
      :contact => "MyString",
      :longitude => 1.5,
      :latitude => 1.5
    ))
  end

  it "renders the edit apartment form" do
    render

    assert_select "form[action=?][method=?]", apartment_path(@apartment), "post" do

      assert_select "input#apartment_address[name=?]", "apartment[address]"

      assert_select "input#apartment_name[name=?]", "apartment[name]"

      assert_select "input#apartment_contact[name=?]", "apartment[contact]"

      assert_select "input#apartment_longitude[name=?]", "apartment[longitude]"

      assert_select "input#apartment_latitude[name=?]", "apartment[latitude]"
    end
  end
end
