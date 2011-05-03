class NotificationMailer < ActionMailer::Base
  helper :mail

  def notify(user, notification)
    @user = user
    @notification = notification

    mail :to => @user.email,
         :from => "%s <%s>" % [I18n.translate('app.name'), I18n.translate('email.noreply')],
         :subject => @notification.cause.title
  end
end
