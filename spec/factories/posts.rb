# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    description "Sessarii"
    short_url "asd123"
    latitude 60.23532878799999
    longitude 24.84594761799999
    attendee_count 0 
  end
end