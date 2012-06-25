# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    description "MyText"
    short_url "MyString"
  end
end
