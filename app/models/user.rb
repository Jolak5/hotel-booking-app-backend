class User < ApplicationRecord
  has_secure_password
  has_many :user_hotels
  has_many :hotels, through: :user_hotels
  has_many :reservations

  validates :name, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
end
