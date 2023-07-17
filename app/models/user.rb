class User < ApplicationRecord
  has_many :user_hotels
  has_many :hotels, through: :user_hotels
end
