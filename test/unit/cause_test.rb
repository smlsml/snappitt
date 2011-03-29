require 'test_helper'

class CauseTest < ActiveSupport::TestCase

  test "fixture" do
    cause = causes(:moment_create)
    assert_kind_of Cause, cause
    assert_kind_of Moment::CreateCause, cause
    assert_kind_of Moment, cause.action
    assert_kind_of Experience, cause.subject
  end

end