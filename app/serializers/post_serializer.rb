# frozen_string_literal: true

class PostSerializer
  include JSONAPI::Serializer
  attributes :title, :content

  belongs_to :user
  has_many :categories
end
