class ProductsController < ApplicationController
  before_action :set_instance_variables

  def pakwheels_sell_it_for_me_new
  end

  private
   
  def set_instance_variables
    @registeration = ["Un-Registered"]
    @provinces = ["Punjab", "Sindh"]
    cities = []
    @popular_cities = ["Karachi", "Lahore", "Islamabad", "Rawalpindi", "Peshawar"]
    states = CS.states(:PK)
    states.keys.each do |state|
      cities.push(CS.cities(state))
    end
    @other_cities = cities.flatten - @popular_cities
  end
end
