require 'test_helper'

class GeocodeTest < ActiveSupport::TestCase

  test "fixture" do
    assert_kind_of Geocode, geocodes(:denver)
  end

end