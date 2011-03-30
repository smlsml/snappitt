class NotificationMailer < ActionMailer::Base
  default :from => "noreply@snappitt.com"

  def notify(user, notification)
    @user = user
    @notification = notification

    mail :to => @user.email,
         :subject => @notification.cause.verb.upcase
  end
end
