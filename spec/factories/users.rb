FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name}
    birth_date { Time.now - 13.years }
    sequence(:email) { |n| "#{n}@gmail.com" }
    password { 'password' }
  end
end
