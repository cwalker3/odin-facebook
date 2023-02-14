FactoryBot.define do
  factory :friendship do
    requestor_id { 1 }
    requestee_id { 1 }
    status { "MyString" }
  end
end
