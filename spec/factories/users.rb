# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username "MyString"
    email "MyString"
    encrypted_password "MyString"
    salt "MyString"
  end
end
