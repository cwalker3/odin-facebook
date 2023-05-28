FactoryBot.define do
  factory :post do
    association :user
    body { Faker::GreekPhilosophers.quote }
  end
end
