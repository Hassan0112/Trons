class SessionController < ApplicationController

  def logout
      reset_session
      redirect_to root_path, notice: "You have been logged out successfully."
  end
  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'You have been signed out successfully.'
  end

  end