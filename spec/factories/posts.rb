# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { Faker::Books::Lovecraft.tome }
    content { Faker::Books::Lovecraft.paragraph }
    published_at { Faker::Date.between(from: 2.month.ago, to: Date.today) }
    user
  end
end
