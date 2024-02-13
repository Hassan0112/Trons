class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable
  has_one_attached :profile_picture
  validates :full_name, :email, presence: true
  validates :username, uniqueness: true, allow_blank: true

end