class NotificationMailer < ActionMailer::Base
  default :from => "noreply@%s" % I18n.translate('app.host')
  helper :mail

  def notify(user, notification)
    @user = user
    @notification = notification

    mail :to => @user.email,
         :from => "%s <%s>" % [I18n.translate('app.name'), 'noreply@snappitt.com'],
         :subject => @notification.cause.title
  end
end
