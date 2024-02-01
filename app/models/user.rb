class User < ApplicationRecord  
  devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable
  has_one_attached :profile_picture
  validates :full_name, :gender, :country, :city, :username, presence: true
  validates :username, uniqueness: true
  validates :price, presence: true, 
            format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0, less_than: 1000000 }
  validates :password, :password_confirmation, presence: true  
  has_many :user_adds
end
