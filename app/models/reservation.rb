class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :hotel

  validates :reservation_date, presence: true
end
