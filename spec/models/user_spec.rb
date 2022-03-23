# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  allow_password_change  :boolean          default(FALSE)
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  name                   :string
#  nickname               :string
#  image                  :string
#  email                  :string
#  tokens                 :json
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  admin                  :boolean          default(FALSE), not null
#  description            :string           default("description"), not null
#  id                     :uuid             not null, primary key
#
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
