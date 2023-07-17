class HotelController < ApplicationController
    def hotel_name
      @hotel_name = Hotel.all.sample
      render json: { message: @hotel_name.name }
    end
  end