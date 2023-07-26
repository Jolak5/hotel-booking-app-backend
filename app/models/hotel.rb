class Hotel < ApplicationRecord
  has_one_attached :image
  has_many :user_hotels
  has_many :users, through: :user_hotels
  has_many :reservations
  
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :duration, numericality: { only_integer: true, greater_than: 0 }
end
