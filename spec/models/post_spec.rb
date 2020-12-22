# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  subject do
    described_class.new(
      title: 'test post title',
      content: 'this is a long content',
      published_at: '2020-12-01',
      user: User.new
    )
  end

  it 'is valid with attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without content' do
    subject.content = nil
    expect(subject).to_not be_valid
  end

  it { should belong_to(:user) }

  it { should have_many(:categories) }
end
