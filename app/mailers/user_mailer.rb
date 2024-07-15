class UserMailer < ApplicationMailer
  default from: 'bhattiali4469@gmail.com'

  def welcome_email(user, verification_code)
    @user = user
    @verification_code = verification_code
    @url  = 'http://localhost:3000/login'
    mail(to: @user.email, subject: 'Welcome to PakWheels')
  end
end
