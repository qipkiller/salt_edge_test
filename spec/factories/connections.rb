FactoryBot.define do
    factory :connection do
      user
      sequence(:remote_id) { Faker::Number.number(digits: 10) }
    end
  end
  