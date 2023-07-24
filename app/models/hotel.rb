class Hotel < ApplicationRecord
  has_one_attached :image
  has_many :user_hotels
  has_many :users, through: :user_hotels
end
