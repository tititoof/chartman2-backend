# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  id         :uuid             not null, primary key
#
FactoryBot.define do
  factory :category do
    name { Faker::Books::CultureSeries.unique.book }
  end
end
