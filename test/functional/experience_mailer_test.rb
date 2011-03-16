require 'test_helper'

class ExperienceMailerTest < ActionMailer::TestCase

  test "upload_notification" do
    @experience = experiences(:public)
    mail = ExperienceMailer.upload_notification(@experience)
    assert_match "Experience", mail.subject
    assert_equal [@experience.creator.email], mail.to
    assert_equal ["noreply@snappitt.com"], mail.from
    assert_match "experience", mail.body.encoded
  end

end
