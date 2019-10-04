FactoryBot.define do
  factory :transaction do
    merchant
    amount { 5000 }
  end
end
