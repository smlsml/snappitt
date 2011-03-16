class ExperienceMailer < ActionMailer::Base
  default :from => "noreply@snappitt.com"

  def upload_notification(experience)
    @experience = experience

    mail :to => @experience.creator.email,
         :from => "Snappitt <reply-post@snappitt.com>"
  end
end
