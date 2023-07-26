require 'swagger_helper'

RSpec.describe 'Hotels API', type: :request do
  path '/hotels' do
    get 'Retrieves all hotels' do
      tags 'Hotels'
      produces 'application/json'

      response '200', 'hotels found' do
        run_test!
      end
    end

    post 'Creates a hotel' do
      tags 'Hotels'
      consumes 'application/json'
      parameter name: :hotel, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          duration: { type: :integer },
          price: { type: :integer },
          image: { type: :string }
        },
        required: %w[name description duration price image]
      }

      response '201', 'hotel created' do
        let(:hotel) do
          { name: 'Test Hotel', description: 'This is a test',
            duration: 2, price: 100, image: 'image_url' }
        end
        run_test!
      end
    end
  end

  path '/hotels/{id}' do
    get 'Retrieves a hotel' do
      tags 'Hotels'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer
      response '200', 'hotel found' do
        let(:id) do
          Hotel.create(name: 'Test Hotel', description: 'This is a test', duration: 2, price: 100,
                       image: 'image_url').id
        end
        run_test!
      end

      response '404', 'hotel not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    delete 'Deletes a hotel' do
      tags 'Hotels'
      parameter name: :id, in: :path, type: :integer
      response '204', 'hotel deleted' do
        let(:id) do
          Hotel.create(name: 'Test Hotel', description: 'This is a test', duration: 2, price: 100,
                       image: 'image_url').id
        end
        run_test!
      end
    end
  end
end
