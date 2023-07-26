require 'rails_helper'

RSpec.describe 'Hotels', type: :request do
  let(:user) { User.create!(name: 'Test User', password: 'password') }
  let!(:auth_token) do
    post '/sessions', params: { name: user.name, password: 'password' }
    json = JSON.parse(response.body)
    json['token']
  end
  let(:hotel) { Hotel.create!(name: 'Hotel California', description: 'A lovely place', duration: 5, price: 200.0) }
  let(:headers) { { 'Authorization' => "Bearer #{auth_token}" } }

  describe 'GET /index' do
    it 'returns http success' do
      get('/hotels', headers:)
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /hotels/:id' do
    it 'returns http success' do
      get("/hotels/#{hotel.id}", headers:)
      expect(response.status).to eq(200)
    end

    it 'returns the correct hotel' do
      get("/hotels/#{hotel.id}", headers:)
      json = JSON.parse(response.body)
      expect(json['id']).to eq(hotel.id)
      expect(json['name']).to eq('Hotel California')
    end
  end

  describe 'POST /create' do
    it 'creates a hotel' do
      post('/hotels',
           params: { hotel: { name: 'Hotel California',
                              description: 'A lovely place',
                              duration: 5, price: 200.0 } }, headers:)
      expect(response.status).to eq(201)
    end

    it 'fails to create a hotel with missing params' do
      post('/hotels',
           params: { hotel: { name: 'Hotel California', description: 'A lovely place', duration: 5 } }, headers:)
      expect(response.status).to eq(422)
    end
  end

  describe 'DELETE /delete' do
    it 'deletes a hotel' do
      delete("/hotels/#{hotel.id}", headers:)
      expect(response.status).to eq(204)
    end
  end
end
