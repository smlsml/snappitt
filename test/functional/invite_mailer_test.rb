require 'test_helper'

class InviteMailerTest < ActionMailer::TestCase

  test "invite" do
    mail = InviteMailer.invite(Invite.new(:user => users(:snoop), :to => users(:dre), :experience => experiences(:public)))
    assert_match "invites you", mail.subject
    assert_equal [users(:dre).email], mail.to
    assert_match "Hello", mail.body.encoded
    p mail.body.encoded
  end

end
