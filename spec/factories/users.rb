# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    provider "twitter"
    uid "174959643"
    name "Bob B."
    nickname "bobbieb"
    email 'bobo@example.com'
    image 'http://a0.twimg.com/profile_images/1837950201/avatar_normal.jpg'
    description 'This is my nice description'
    foursq_token 'FZA235ZWUS3ETFPZC5PXUYEFZRDOMYINFEGZOZPE5VXW5AQV'
  end
end