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
require 'rails_helper'

RSpec.describe Category, type: :model do
  subject do
    described_class.new(
      name: 'test category name'
    )
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil

    expect(subject).not_to be_valid
  end
end
