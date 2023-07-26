require 'swagger_helper'

describe 'Reservations API' do
  path '/reservations' do
    get 'Retrieves all reservations' do
      tags 'Reservations'
      produces 'application/json'

      response '200', 'reservations found' do
        run_test!
      end
    end

    post 'Creates a reservation' do
      tags 'Reservations'
      consumes 'application/json'
      parameter name: :reservation, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :integer },
          hotel_id: { type: :integer },
          reservation_date: { type: :string, format: :'date-time' }
        },
        required: %w[user_id hotel_id reservation_date]
      }

      response '201', 'reservation created' do
        let(:reservation) { { user_id: 1, hotel_id: 1, reservation_date: '2023-01-01T00:00:00Z' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:reservation) { { user_id: 1, hotel_id: 1, reservation_date: '' } }
        run_test!
      end
    end
  end

  path '/reservations/{id}' do
    get 'Retrieves a reservation' do
      tags 'Reservations'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'reservation found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 user_id: { type: :integer },
                 hotel_id: { type: :integer },
                 reservation_date: { type: :string, format: :'date-time' }
               }

        let(:id) { Reservation.create(user_id: 1, hotel_id: 1, reservation_date: '2023-01-01T00:00:00Z').id }
        run_test!
      end

      response '404', 'reservation not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Updates a reservation' do
      tags 'Reservations'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :reservation, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :integer },
          hotel_id: { type: :integer },
          reservation_date: { type: :string, format: :'date-time' }
        },
        required: %w[user_id hotel_id reservation_date]
      }

      response '204', 'reservation updated' do
        let(:id) { Reservation.create(user_id: 1, hotel_id: 1, reservation_date: '2023-01-01T00:00:00Z').id }
        let(:reservation) { { user_id: 2, hotel_id: 2, reservation_date: '2023-02-01T00:00:00Z' } }
        run_test!
      end

      response '404', 'reservation not found' do
        let(:id) { 'invalid' }
        let(:reservation) { { user_id: 2, hotel_id: 2, reservation_date: '2023-02-01T00:00:00Z' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:id) { Reservation.create(user_id: 1, hotel_id: 1, reservation_date: '2023-01-01T00:00:00Z').id }
        let(:reservation) { { user_id: 2, hotel_id: 2, reservation_date: '' } }
        run_test!
      end
    end

    delete 'Deletes a reservation' do
      tags 'Reservations'
      parameter name: :id, in: :path, type: :integer

      response '204', 'reservation deleted' do
        let(:id) { Reservation.create(user_id: 1, hotel_id: 1, reservation_date: '2023-01-01T00:00:00Z').id }
        run_test!
      end

      response '404', 'reservation not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
