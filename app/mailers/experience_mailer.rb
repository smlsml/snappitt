class ExperienceMailer < ActionMailer::Base
  default :from => "noreply@%s" % I18n.translate('app.host')

  def upload_notification(experience)
    @experience = experience
    @group = 'post%s@%s' % [@experience.id, I18n.translate('app.host')]
    group = @group

    mail :to => @experience.creator.email,
         :from => "%s on %s <%s>" % [@experience.creator, I18n.translate('app.name'), @group],
         :reply_to => @group
  end
end
