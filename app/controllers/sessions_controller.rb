class SessionsController < ApplicationController
    skip_before_action :authorized, only: [:create]
    def create
      user = User.find_by(name: params[:name])
  
      if user && user.authenticate(params[:password])
        render json: { token: encode_token({ user_id: user.id }) }
      else
        render json: { error: 'Invalid username or password' }
      end
    end
  end
  