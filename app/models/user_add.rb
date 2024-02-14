class UserAdd < ApplicationRecord
  belongs_to :user
  validates :city, :exterior_color, :mileage, :price, :add_description, :mobile_number, presence: true
  has_many_attached :images
end
