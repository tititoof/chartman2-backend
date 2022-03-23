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
class Category < ApplicationRecord
  has_many :articles
  has_many :posts, through: :articles

  validates_presence_of :name

  validates_uniqueness_of :name
end
