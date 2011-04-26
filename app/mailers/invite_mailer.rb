class InviteMailer < ActionMailer::Base

  def invite(inv)
    @invite = inv

    p @invite.email

    mail :to => @invite.email,
         :bcc => @invite.user.email,
         :subject => '%s invites you to help capture your experience' % @invite.user
  end
end
