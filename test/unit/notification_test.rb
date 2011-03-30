require 'test_helper'

class NotificationTest < ActiveSupport::TestCase

  test "fixture" do
    note = notifications(:snoop_like)
    assert_kind_of Cause, note.cause
    assert_equal users(:snoop), note.user
  end

  test "no duplicates" do
    note = notifications(:snoop_like)
    two = note.clone
    assert !two.valid?
  end

end
