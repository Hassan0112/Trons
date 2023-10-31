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
  private

  def user_params
    params.require(:user).permit(:email, :password, :full_name, :profile_picture)
  end
  
end
