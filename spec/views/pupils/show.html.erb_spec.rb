require 'spec_helper'

describe "pupils/show" do
  before(:each) do
    @pupil = assign(:pupil, stub_model(Pupil,
      :given_name => "Given Name",
      :other_name => "Other Name",
      :family_name => "Family Name",
      :name_known_by => "Name Known By",
      :gender => 1,
      :image_path => "Image Path"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Given Name/)
    rendered.should match(/Other Name/)
    rendered.should match(/Family Name/)
    rendered.should match(/Name Known By/)
    rendered.should match(/1/)
    rendered.should match(/Image Path/)
  end
end
