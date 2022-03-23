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
