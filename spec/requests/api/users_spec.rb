require 'swagger_helper'

RSpec.describe 'Users API', type: :request do
  path '/users' do
    get 'Retrieves all users' do
      tags 'Users'
      produces 'application/json'
    end

    post 'Creates a user' do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          password: { type: :string }
        },
        required: %w[name password]
      }
    end
  end

  path '/users/{id}' do
    get 'Retrieves a user' do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      response '200', 'user found' do
        schema '$ref' => '#/components/schemas/User'
        let(:id) { User.create(name: 'John', password: 'password123').id }
        run_test!
      end
    end

    delete 'Deletes a user' do
      tags 'Users'
      parameter name: :id, in: :path, type: :string
      response '204', 'user deleted' do
        let(:id) { User.create(name: 'John', password: 'password123').id }
        run_test!
      end
    end
  end
end
