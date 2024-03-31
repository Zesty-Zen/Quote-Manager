class SendWeeklyEmailJob < ApplicationJob
    queue_as :default
  
    def perform
      users = User.all
      users.each do |user|
        UserMailer.weekly_email(user).deliver_now
      end
    end
  end