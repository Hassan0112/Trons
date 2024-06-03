class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:pakwheels_sell_it_for_me_new, :submit_form]
  before_action :set_instance_variables
  skip_before_action :verify_authenticity_token, only: [:resend_code, :verify_code]

  def pakwheels_sell_it_for_me_new
    @sellitforme_form = SellitformeForm.new
  end

  def submit_form
    @sellitforme_form = SellitformeForm.new(sellitforme_form_params)
    if @sellitforme_form.save
      verification_code = rand(1000..9999).to_s
      formatted_phone = "+17759865200"
  
      send_message("Your verification code is Hassan: #{verification_code}", formatted_phone)

      session[:verification_code] = verification_code
      session[:phone] = formatted_phone

      redirect_to account_verification_path, notice: "Verification code sent successfully."
    else
      flash.now[:alert] = @sellitforme_form.errors.full_messages
      render 'pakwheels_sell_it_for_me_new'
    end
  end

  def verify_code
    if params[:verification_code] == session[:verification_code]
      
      flash[:notice] = "Phone number verified successfully."
      session.delete(:verification_code)
      session.delete(:phone)
      redirect_to root_path
    else
      flash[:alert] = "Invalid verification code. Please try again."
      redirect_to account_verification_path
    end
  end

  def resend_code
    verification_code = rand(1000..9999).to_s
    formatted_phone = "+17759865200"	
    
    if send_message("Your verification code is: #{verification_code}", formatted_phone)
      session[:verification_code] = verification_code
      session[:code_sent_time] = Time.now
      render json: { success: true }
    else
      render json: { success: false }
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

  def send_message(message, phone)
    account_sid = ENV['SECRET_KEY']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    twilio_number = ENV['TWILIO_PHONE_NUMBER']
  
    begin
      @client = Twilio::REST::Client.new(account_sid, auth_token)
      validated_phone = @client.lookups.v1.phone_numbers(phone).fetch.country_code
  
      message = @client.messages.create(
        from: twilio_number,
        to: phone,
        body: message
      )
      puts "Message sent successfully: #{message.sid}"
    rescue Twilio::REST::RestError => e
      puts "Twilio Error: #{e.message}"
      flash[:error] = 'Error sending message'
    end
  end
end
