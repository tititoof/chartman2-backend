# frozen_string_literal: true

class CategorySerializer
  include JSONAPI::Serializer
  attributes :name

  has_many :posts
end
