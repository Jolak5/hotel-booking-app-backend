require 'rails_helper'

RSpec.describe 'Reservations', type: :request do
  let(:user) { User.create!(name: 'Test User', password: 'password') }
  let!(:auth_token) do
    post '/sessions', params: { name: user.name, password: 'password' }
    json = JSON.parse(response.body)
    json['token']
  end
  let(:hotel) { Hotel.create!(name: 'Hotel California', description: 'A lovely place', duration: 5, price: 200.0) }
  let(:reservation) do
    Reservation.create!(user:, hotel:, reservation_date: Date.today, duration: 5)
  end
  let(:headers) { { 'Authorization' => "Bearer #{auth_token}" } }

  describe 'GET /index' do
    it 'returns http success' do
      get('/reservations', headers:)
      expect(response.status).to eq(200)
    end
  end

  describe 'POST /create' do
    it 'creates a reservation' do
      post('/reservations',
           params: { reservation: { user_id: user.id, hotel_id: hotel.id, reservation_date: Date.tomorrow, duration: 2 } }, headers:)
      expect(response.status).to eq(201)
    end

    it 'fails to create a reservation with missing params' do
      post('/reservations', params: { reservation: { user_id: user.id, duration: 2 } }, headers:)
      expect(response.status).to eq(422)
    end
  end
end
