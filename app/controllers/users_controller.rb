class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]


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
        format.html { redirect_to root_path, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else

        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
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
