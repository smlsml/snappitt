require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "fixture" do
    one = users(:one)
    assert_kind_of(User, one)
  end
end
