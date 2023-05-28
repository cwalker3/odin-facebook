FactoryBot.define do
  factory :liking do
    association :user
    association :likeable
  end
end
