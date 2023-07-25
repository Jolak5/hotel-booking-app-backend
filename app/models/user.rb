class User < ApplicationRecord
  has_secure_password
  has_many :user_hotels
  has_many :hotels, through: :user_hotels
  has_many :reservations
end
