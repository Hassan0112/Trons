class UsedCarsController < ApplicationController
  before_action :authenticate_user!, only: [:post_ad, :submit_form, :new_ad]
  before_action :set_instance_variables, only: [:new_ad, :submit_form]

  def post_ad
  end

  def new_ad
    @user_add = UserAdd.new
  end

  def submit_form
    @user_add = UserAdd.new(user_add_params)
    if @user_add.save
      redirect_to used_cars_sell_path, notice: "Car Add Submitted Successfully."
    else
      flash.now[:alert] = "Failed to submit car ad. Please check your inputs."
      render :new_ad
    end
  end

  private

  def set_instance_variables
    @rigisteration = ["Un-Rigistered"]
    @provinces = ["Punjab", "Sindh"]
    cities = []
    @popular_cities = ["Karachi", "Lahore", "Islamabad", "Rawalpindi", "Peshawar"]
    states = CS.states(:PK)
    states.keys.each do |state|
      cities.push(CS.cities(state))
    end
    @other_cities = cities.flatten - @popular_cities
  end

  def user_add_params
    params.require(:user_add).permit(:city, :registered_in, :exterior_color, :mileage, :price, :add_description, :mobile_number, :secondary_number, :user_id, images: [])
  end
end