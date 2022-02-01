# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { Faker::Books::CultureSeries.unique.book }
  end
end
