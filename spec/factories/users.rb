FactoryBot.define do
  factory :user do
    sequence(:email) { Faker::Internet.email }
    sequence(:password) { Faker::Internet.password(min_length: 8) }
  end
end
