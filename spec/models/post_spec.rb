# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  subject do
    described_class.new(
      title: 'test post title',
      description: 'test description',
      content: 'this is a long content',
      published: true,
      published_at: '2020-12-01',
      user: User.new,
      categories: [FactoryBot.create(:category)]
    )
  end

  it 'is valid with attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without title' do
    subject.title = nil

    expect(subject).not_to be_valid
  end

  it 'is not valid without content' do
    subject.content = nil

    expect(subject).not_to be_valid
  end

  it 'is not valid without published' do
    subject.published = false

    expect(subject).not_to be_valid
  end

  it 'is not valid without published_at' do
    subject.published_at = nil

    expect(subject).not_to be_valid
  end

  it { is_expected.to belong_to(:user) }

  it { is_expected.to have_many(:categories) }
end
