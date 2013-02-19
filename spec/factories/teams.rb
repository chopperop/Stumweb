# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team do
    team_name "MyString"
    username "MyString"
    team_score 1
  end
end
