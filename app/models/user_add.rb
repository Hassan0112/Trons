class UserAdd < ApplicationRecord
  belongs_to :user
  validates :city, :registered_in, :exterior_color, :mileage, :price, :add_description, :mobile_number, :images, presence: true
  has_many_attached :images
end
