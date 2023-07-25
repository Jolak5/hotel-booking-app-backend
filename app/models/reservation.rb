class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :hotel

  # validates :reservation_date, presence: true
  def user_name
    user&.name || 'User information not available'
  end

  def hotel_name
    hotel&.name || 'Hotel information not available'
  end
end
