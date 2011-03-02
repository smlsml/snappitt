require 'test_helper'

class EventTest < ActiveSupport::TestCase

  test "fixture" do
    one = events(:one)
    assert_kind_of(Event, one)
  end

  test "experience association" do
    event = events(:one)
    exp = events(:one).experience
    assert_kind_of(Experience, exp)
    assert event === exp.event
  end

end
