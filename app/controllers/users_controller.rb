class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    @user = current_user
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
    params.require(:user).permit(:email, :password, :password_confirmation, :full_name, :profile_picture, :current_password)
  end
end
