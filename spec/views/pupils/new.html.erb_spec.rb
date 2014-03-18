require 'spec_helper'

describe "pupils/new" do
  before(:each) do
    assign(:pupil, stub_model(Pupil,
      :given_name => "MyString",
      :other_name => "MyString",
      :family_name => "MyString",
      :name_known_by => "MyString",
      :gender => 1,
      :image_path => "MyString"
    ).as_new_record)
  end

  it "renders new pupil form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", pupils_path, "post" do
      assert_select "input#pupil_given_name[name=?]", "pupil[given_name]"
      assert_select "input#pupil_other_name[name=?]", "pupil[other_name]"
      assert_select "input#pupil_family_name[name=?]", "pupil[family_name]"
      assert_select "input#pupil_name_known_by[name=?]", "pupil[name_known_by]"
      assert_select "input#pupil_gender[name=?]", "pupil[gender]"
      assert_select "input#pupil_image_path[name=?]", "pupil[image_path]"
    end
  end
end
