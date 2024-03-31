class UserMailer < ApplicationMailer

  default from: 'notifications@example.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def quote_created_notification(user, quote)
    @user = user
    @quote = quote
    mail(to: @user.email, subject: 'Quote Created')
  end

end
