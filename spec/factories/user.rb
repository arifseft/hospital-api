FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    email { Faker::Internet.email }
    password { '12345678' }
  end
end
