require 'test_helper'

class EventLocationTest < ActiveSupport::TestCase

  def setup
    @artopia = event_locations(:artopia_denver)
  end

  test "fixture" do
    assert_kind_of(EventLocation, @artopia)
    assert_kind_of(Event, @artopia.event)
    assert_kind_of(Location, @artopia.location)
  end

end
