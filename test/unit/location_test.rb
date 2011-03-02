require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  test "fixture" do
    one = locations(:one)
    assert_kind_of(Location, one)
    assert_equal "Denver", one.city
  end
end
