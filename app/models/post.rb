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
class Post < ApplicationRecord
  belongs_to :user
  has_many :articles
  has_many :categories, through: :articles

  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :content
  validates_presence_of :user
  validates :published_at, presence: { if: -> { published == true } }
  validates :published, presence: { unless: -> { published_at.blank? } }

  validates_uniqueness_of :title

  validates_associated :categories

  scope :from_category, ->(category) { joins(:categories).where('categories.id in (?)', category) }
  scope :published, -> { where('published = ?', true) }
end
