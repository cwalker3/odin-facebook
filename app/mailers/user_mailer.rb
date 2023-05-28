class UserMailer < ApplicationMailer
  default from: 'example@example.com'
  
  def welcome_email
    @user = params[:user]
    @url = user_session_url
    mail(to: @user.email, subject: 'Welcome to Odin Facebook!')
  end
end
