class ExperienceMailer < ActionMailer::Base
  default :from => "noreply@%s" % I18n.translate('app.host')

  def upload_notification(experience)
    @experience = experience
    @reply_to = 'exp%s@%s' % [@experience.id, I18n.translate('app.host')]

    mail :to => @experience.creator.email,
         :from => "%s on %s <%s>" % [@experience.creator, I18n.translate('app.name'), @reply_to],
         :reply_to => @reply_to
  end
end
