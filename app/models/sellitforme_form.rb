class SellitformeForm < ApplicationRecord
  belongs_to :user
  validates :user, presence: true

  validates :model_year, presence: true
  validates :car_info, presence: true
  validates :assembly, presence: true
  validates :location, presence: true
  validates :address, presence: true
  validates :inspection_slot, presence: true
  validates :full_name, presence: true
  validates :phone, presence: true 
end
