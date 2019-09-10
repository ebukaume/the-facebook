# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    association :liker, factory: :user
  end

  factory :comment do
    content { Faker::Lorem.paragraph }
    association :author, factory: :user
    association :post, factory: :post
  end

  factory :post do
    content { Faker::Lorem.paragraph }
    association :author, factory: :user
  end

  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:email) { |n| "user#{n}@email.com" }
    password { Faker::Internet.password }
    sex { %w[Male Female Custom].sample }
    dob { 20.years.ago }
    image { 'http://www.gravatar.com/avatar/3b3be63a4c2a439b013787725dfce802' }
  end
end
