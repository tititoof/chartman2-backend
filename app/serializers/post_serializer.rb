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
class PostSerializer
  include JSONAPI::Serializer
  attributes :title, :description, :content, :published, :published_at

  belongs_to :user
  has_many :categories
end
