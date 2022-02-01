# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(
      name: 'Test user name',
      email: 'toto@toto.fr',
      password: 'password'
    )
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil

    expect(subject).not_to be_valid
  end

  it 'is not valid without an email' do
    subject.email = nil

    expect(subject).not_to be_valid
  end

  it 'is not valid without a password' do
    subject.password = nil

    expect(subject).not_to be_valid
  end

  it { is_expected.to allow_value('user@example.com').for(:email) }
  it { is_expected.not_to allow_value('not-an-email').for(:email) }
  it { is_expected.to have_many(:posts) }
end
