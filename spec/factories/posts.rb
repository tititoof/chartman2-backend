# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  title        :string
#  content      :text
#  published_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  description  :string           default("description"), not null
#  id           :uuid             not null, primary key
#  user_id      :uuid             not null
#  published    :boolean
#
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
