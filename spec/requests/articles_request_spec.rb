# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  it 'show articles' do
    category = FactoryBot.create(:category)
    get "/articles/#{category.id}"

    expect(response.status).to eq(200)
  end
end
