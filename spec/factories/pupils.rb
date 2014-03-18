# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pupil do
    given_name "MyString"
    other_name "MyString"
    family_name "MyString"
    name_known_by "MyString"
    dob "2014-02-19"
    gender 1
    image_path "MyString"
  end
end
