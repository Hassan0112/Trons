class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable
  has_one_attached :profile_picture
  has_many :user_adds
  validates :username, uniqueness: true, allow_blank: true

end
