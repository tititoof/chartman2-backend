# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { Faker::Books::Lovecraft.tome }
    description { Faker::Books::Lovecraft.sentences }
    content { Faker::Books::Lovecraft.paragraph }
    published_at { Faker::Date.between(from: 2.month.ago, to: Date.today) }
    user
    categories { FactoryBot.create_list(:category, 1) }
  end
end
