require 'test_helper'

class EventTest < ActiveSupport::TestCase

  test "fixture" do
    one = events(:one)
    assert_kind_of(Event, one)
  end
end
