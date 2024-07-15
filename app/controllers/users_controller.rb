class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create, :verify, :confirm_verification, :resend_verification_code]
  skip_before_action :verify_authenticity_token, only: [:resend_verification_code]

  def new
    @user = User.new
  end
  
  def profile
    @user = current_user
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:temporary_user_id] = @user.id
        @verification_code_user = rand(1000..9999).to_s
        session[:verification_code_em] = @verification_code_user
        UserMailer.welcome_email(@user, @verification_code_user).deliver_now
        flash[:notice] = 'User was successfully created. Please check your email for verification instructions.'
        format.html { redirect_to verify_path(@user.id)}
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def verify
    @user = User.find(session[:temporary_user_id])
  end

  def confirm_verification
    @user = User.find(session[:temporary_user_id])
    verification_data = session[:verification_code_em]

    if session[:verification_code_em] == params[:verification_code]
      @user.update(email_verified: true)
      session.delete(:verification_code_em)
      sign_in(@user) 
      redirect_to root_path, notice: 'Email successfully verified.'
    else
      flash.now[:alert] = 'Invalid verification code.'
      render :verify
    end
  end

  def resend_verification_code
    byebug
    user = User.find(session[:temporary_user_id])
    verification_code_user = rand(1000..9999).to_s
    session[:verification_code_em] = verification_code_user
    UserMailer.welcome_email(user, verification_code_user).deliver_now
    render json: { success: true }
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to root_path, notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end

  def update_profile_picture
    @user = current_user
    if @user.update(user_params)
      redirect_to root_path, notice: 'Profile picture updated successfully.'
    else
      render :profile
    end
  end

  def edit_password
    @user = current_user
  end
  
  def update_password
    @user = current_user
  
    if @user.valid_password?(user_params[:current_password])
      if @user.update_with_password(user_params)
        @user.save
        redirect_to root_path, notice: 'Password successfully updated.'
      else
        flash.now[:custom_alert] = @user.errors.full_messages.join(", ") unless @user.errors.details.key?(:current_password)
        render :edit_password
      end
    else
      flash.now[:custom_alert] = "Incorrect current password."
      render :edit_password
    end
  end
  

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :full_name, :profile_picture)
  end
end