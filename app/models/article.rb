# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  id          :uuid             not null, primary key
#  post_id     :uuid             not null
#  category_id :uuid             not null
#
class Article < ApplicationRecord
  belongs_to :post
  belongs_to :category
end
