require 'test_helper'

class EventLocationTest < ActiveSupport::TestCase

  test "fixture" do
    one = event_locations(:one)
    assert_kind_of(EventLocation, one)
  end

  test "belongs_to event" do
    assert_kind_of(Event, event_locations(:one).event)
  end

  test "belongs_to location" do
    assert_kind_of(Location, event_locations(:one).location)
  end

end
