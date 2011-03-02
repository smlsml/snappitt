require 'test_helper'

class ThingTest < ActiveSupport::TestCase

  test "fixture" do
    one = things(:one)
    assert_kind_of(Thing, one)
  end
end
