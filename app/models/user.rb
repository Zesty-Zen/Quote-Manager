class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :quotes

  def name
    email.split("@").first.capitalize       #Splits at first occurence of @
    #email.split(/\d/, 2).first.capitalize    #Splits at first occurence of any number

  end

  

  after_create :send_welcome_email

  private

  def send_welcome_email
    UserMailer.with(user: self).welcome_email.deliver_now
  end

end
