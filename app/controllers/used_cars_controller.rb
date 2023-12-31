class UsedCarsController < ApplicationController
  def post_ad
    # Your controller logic goes here
  end

  def new_ad
    cities = []
    @popular_cities = ["Karachi", "Lahore", "Islamabad", "Rawalpindi", "Peshawar"]
    states = CS.states(:PK)
    states.keys.each do |state|
      cities.push(CS.cities(state))
    end
    @other_cities = cities.flatten - @popular_cities
  end

  private

  def user_params
    params.permit(:city, :state)
  end

  
end