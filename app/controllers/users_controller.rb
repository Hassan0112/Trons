class UsersController < Devise::RegistrationsController
  before_action :set_devise_variables, if: :devise_controller?
  def new
    @resource = User.new
  end
      
  def create
    @user = User.new(user_params)
  
    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  

  private

  def user_params
    params.require(:user).permit(:email, :password, :full_name)
  end

  def set_devise_variables
    @resource = User.new
    @resource_name = :user
  end
end
