# frozen_string_literal: true

class PostSerializer
  include JSONAPI::Serializer
  attributes :title, :description, :content

  belongs_to :user
  has_many :categories
end
