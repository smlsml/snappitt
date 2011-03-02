require 'test_helper'

class ProfileTest < ActiveSupport::TestCase

  test "fixture" do
    one = profiles(:one)
    assert_kind_of(Profile, one)
  end
end
