class ExperienceMailer < ActionMailer::Base
  default :from => "noreply@%s" % I18n.translate('app.host')

  def upload_notification(experience, user, is_new)
    @experience = experience
    @user = user
    @is_new = is_new
    @group_address = 'post%s@%s' % [experience.id, I18n.translate('app.host')]
    @causes = Cause.for_experience(@experience).limit(5)

    mail :to => @user.email,
         :from => "%s on %s <%s>" % [@user, I18n.translate('app.name'), @group_address],
         :reply_to => @group_address
  end
end
