class User < ApplicationRecord
  has_secure_password
  has_many :reservations, dependent: :destroy
  has_many :hotels, through: :reservations

  validates :name, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
end
