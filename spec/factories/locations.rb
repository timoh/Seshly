# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    name "MyString"
    foursq_id "MyString"
    street_address "MyString"
    cross_street "MyString"
    city "MyString"
    state "MyString"
    postal_code "MyString"
    country "MyString"
    lat 1.5
    lng 1.5
  end
end
