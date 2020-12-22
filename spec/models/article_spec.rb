# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'associations' do
    it { should belong_to(:category) }
    it { should belong_to(:post) }
  end
end
