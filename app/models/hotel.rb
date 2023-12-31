class Hotel < ApplicationRecord
  has_one_attached :image
  has_many :reservations, dependent: :destroy
  has_many :users, through: :reservations

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :duration, presence: true, numericality: { greater_than: 0 }
end
