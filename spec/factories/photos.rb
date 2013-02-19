# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :photo do
    user_id 1
    image "MyString"
    content_changed_at "2012-12-11 15:19:56"
  end
end
