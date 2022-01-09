# frozen_string_literal: true

class CategorySerializer
  include JSONAPI::Serializer
  attributes :name, :created_at

  attribute :published_count do |record|
    record.posts.select { |post| post.published }.count
  end

  has_many :posts
end
