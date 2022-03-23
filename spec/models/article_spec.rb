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
require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to belong_to(:post) }
  end
end
