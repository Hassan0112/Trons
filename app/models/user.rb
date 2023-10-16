class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  validates :full_name, :gender, :country, :city, :username, presence: true
  validates :username, uniqueness: true
end
