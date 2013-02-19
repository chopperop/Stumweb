# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :caption do
    body "MyText"
    photo_id 1
  end
end
