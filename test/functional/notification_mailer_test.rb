require 'test_helper'

class NotificationMailerTest < ActionMailer::TestCase

  test "notify" do
    @user = users(:snoop)
    @note = notifications(:snoop_like)
    mail = NotificationMailer.notify(@user, @note)
    assert_equal @note.cause.verb.upcase, mail.subject
    assert_equal [@user.email], mail.to
    assert_equal ["noreply@snappitt.com"], mail.from
    assert_match "Hey", mail.body.encoded
    p mail.body
  end

end
