# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  id          :uuid             not null, primary key
#  post_id     :uuid             not null
#  category_id :uuid             not null
#
FactoryBot.define do
  factory :article do
    post
    category
  end
end
