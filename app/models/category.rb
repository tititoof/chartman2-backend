# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :articles
  has_many :posts, through: :articles

  validates_presence_of :name

  validates_uniqueness_of :name
end
