# frozen_string_literal: true

FactoryBot.define do
  published = Faker::Boolean.boolean

  factory :post do
    title { Faker::Books::Lovecraft.unique.tome }
    description { Faker::Books::Lovecraft.unique.sentences }
    content { Faker::Books::Lovecraft.unique.paragraph }
    published { published }
    published_at { published == true ? Faker::Date.between(from: 2.month.ago, to: Date.today) : nil }
    user
    categories { FactoryBot.create_list(:category, 1) }
  end
end
