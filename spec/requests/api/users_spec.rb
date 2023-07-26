require 'swagger_helper'

RSpec.describe 'Users API', type: :request do
  path '/users' do
    get 'Retrieves all users' do
      tags 'Users'
      produces 'application/json'

      response '200', 'users found' do
        schema type: :array,
          items: { '$ref' => '#/components/schemas/User' }
        run_test!
      end
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
        required: ['name', 'password']
      }

      response '201', 'user created' do
        let(:user) { { name: 'John', password: 'password123' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { name: 'John' } }
        run_test!
      end
    end
  end

  path '/users/{id}' do
    get 'Retrieves a user' do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'user found' do
        schema '$ref' => '#/components/schemas/User'
        let(:id) { User.create(name: 'John', password: 'password123').id }
        run_test!
      end

      response '404', 'user not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Updates a user' do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, :in => :path, :type => :string
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          password: { type: :string }
        },
        required: ['name', 'password']
      }

      response '200', 'user updated' do
        let(:id) { User.create(name: 'John', password: 'password123').id }
        let(:user) { { name: 'Jack', password: 'password123' } }
        run_test!
      end

      response '404', 'user not found' do
        let(:id) { 'invalid' }
        let(:user) { { name: 'Jack', password: 'password123' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:id) { User.create(name: 'John', password: 'password123').id }
        let(:user) { { name: 'Jack' } }
        run_test!
      end
    end

    delete 'Deletes a user' do
      tags 'Users'
      parameter name: :id, :in => :path, :type => :string

      response '204', 'user deleted' do
        let(:id) { User.create(name: 'John', password: 'password123').id }
        run_test!
      end

      response '404', 'user not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end