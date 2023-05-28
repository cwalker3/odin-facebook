FactoryBot.define do
  factory :profile do
    association :user
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    gender { Faker::Gender.type }
    location { Faker::Address.state }
    birth_date { Time.now - 13.years }
  end
end
