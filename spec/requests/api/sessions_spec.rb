require 'swagger_helper'

describe 'Sessions API' do

  path '/sessions' do

    post 'Creates a new session (login)' do
      tags 'Sessions'
      consumes 'application/json'
      parameter name: :session, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          password: { type: :string }
        },
        required: [ 'name', 'password' ]
      }

      response '200', 'session created' do
        let(:session) { { name: 'foo', password: 'password' } }
        run_test!
      end

      response '400', 'invalid username or password' do
        let(:session) { { name: 'foo', password: 'wrong_password' } }
        run_test!
      end
    end
  end
end
