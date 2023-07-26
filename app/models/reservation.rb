class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :hotel

  validates :user_id, presence: true
  validates :hotel_id, presence: true
  validates :reservation_date, presence: true
  validates :duration, numericality: { only_integer: true, greater_than: 0 }
  
  def user_name
    user&.name || 'User information not available'
  end

  def hotel_name
    hotel&.name || 'Hotel information not available'
  end
end