FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    sex { %w(Male Female Custom).sample }
    dob { 20.years.ago }
    image { "http://www.gravatar.com/avatar/3b3be63a4c2a439b013787725dfce802" }
  end

  factory :post do
    sequence(:content) { |n| "Some random content #{n}" }
    association :author, factory: :user
  end
end
