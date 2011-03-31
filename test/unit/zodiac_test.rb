require 'test_helper'

class ZodiacTest < ActiveSupport::TestCase

  test "fixture" do
    assert_kind_of Zodiac, zodiacs(:aries)
  end
end
