# frozen_string_literal: true

class PostSerializer
  include JSONAPI::Serializer
  attributes :title, :description, :content, :published, :published_at

  belongs_to :user
  has_many :categories
end
