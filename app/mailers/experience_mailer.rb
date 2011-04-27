class ExperienceMailer < ActionMailer::Base
  default :from => "noreply@%s" % I18n.translate('app.host')

  def upload_notification(experience, user)
    @experience = experience
    @user = user
    @group_address = experience.upload_email
    @causes = Cause.reject_deleted(Cause.for_experience(@experience).limit(5))

    mail :to => @user.email,
         :from => "%s on %s <%s>" % [@user, I18n.translate('app.name'), @group_address],
         :reply_to => @group_address
  end
end
