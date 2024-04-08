class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:pakwheels_sell_it_for_me_new, :submit_form]
  before_action :set_instance_variables

  def pakwheels_sell_it_for_me_new
    @sellitforme_form = SellitformeForm.new
  end

  def submit_form
    @sellitforme_form = SellitformeForm.new(sellitforme_form_params)
    if @sellitforme_form.save
      redirect_to root_path, notice: "form data was saved successfully"
    else
      flash.now[:alert] = @sellitforme_form.errors.full_messages
      render 'pakwheels_sell_it_for_me_new'
    end
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
    @years = (2000..Time.current.year).to_a.reverse
  end

  def sellitforme_form_params
    params.require(:sellitforme_form).permit(:model_year, :car_info, :registered_in, :assembly, :location, :address, :inspection_slot, :full_name, :phone).merge(user_id: current_user.id)
  end
end
