require 'test_helper'

class LocationTest < ActiveSupport::TestCase

  test "fixture" do
    den = locations(:denver)
    assert_kind_of(Location, den)
    assert_equal "Denver", den.city
  end

end