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
# Category serializer
class CategorySerializer
  include JSONAPI::Serializer
  attributes :name, :created_at

  attribute :published_count do |record|
    record.posts.select(&:published).count
  end

  has_many :posts
end
