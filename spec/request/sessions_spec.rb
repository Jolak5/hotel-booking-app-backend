require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let(:user) { User.create!(name: 'Test User', password: 'password') }
  let!(:auth_token) do
    post '/sessions', params: { name: user.name, password: 'password' }
    json = JSON.parse(response.body)
    json['token']
  end
  let(:headers) { { 'Authorization' => "Bearer #{auth_token}" } }

  describe 'POST /create' do
    it 'authenticates the user' do
      post('/sessions', params: { name: user.name, password: 'password' }, headers:)
      expect(response.status).to eq(200)
    end
  end
end
