class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable
  has_one_attached :profile_picture
  validates :full_name, :gender, :country, :city, :username, presence: true
  validates :username, uniqueness: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  
end
