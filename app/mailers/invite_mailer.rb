class InviteMailer < ActionMailer::Base
  default :from => "noreply@%s" % I18n.translate('app.host')

  def invite(inv)
    @invite = inv

    p @invite.email
    p @invite.user.email

    mail :to => @invite.email,
         :bcc => @invite.user.email,
         :subject => '%s invites you to help capture your experience' % @invite.user
  end
end
