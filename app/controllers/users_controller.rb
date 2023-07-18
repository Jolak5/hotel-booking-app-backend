class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]
  def create
    user = User.create(user_params)
    if user.valid?
      render json: { token: encode_token({ user_id: user.id }) }
    else
      render json: { error: 'Failed to create user' }
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password)
  end
end
