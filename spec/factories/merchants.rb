FactoryBot.define do
  factory :merchant do
    name { "MyString" }
    description { "MyString" }
    email { "MyString" }
    status { "active" }
    total_transaction_sum { "MyString" }
  end
end
