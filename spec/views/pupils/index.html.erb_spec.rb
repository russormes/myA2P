require 'spec_helper'

describe "pupils/index" do
  before(:each) do
    assign(:pupils, [
      stub_model(Pupil,
        :given_name => "Given Name",
        :other_name => "Other Name",
        :family_name => "Family Name",
        :name_known_by => "Name Known By",
        :gender => 1,
        :image_path => "Image Path"
      ),
      stub_model(Pupil,
        :given_name => "Given Name",
        :other_name => "Other Name",
        :family_name => "Family Name",
        :name_known_by => "Name Known By",
        :gender => 1,
        :image_path => "Image Path"
      )
    ])
  end

  it "renders a list of pupils" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Given Name".to_s, :count => 2
    assert_select "tr>td", :text => "Other Name".to_s, :count => 2
    assert_select "tr>td", :text => "Family Name".to_s, :count => 2
    assert_select "tr>td", :text => "Name Known By".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Image Path".to_s, :count => 2
  end
end
