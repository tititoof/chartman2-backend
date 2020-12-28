# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :articles
  has_many :categories, through: :articles

  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :content
  validates_presence_of :user

  validates_uniqueness_of :title

  validates_associated :categories

  scope :from_category, ->(category) { joins(:categories).where('categories.id in (?)', category) }
end
