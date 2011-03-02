require 'test_helper'

class MomentTest < ActiveSupport::TestCase

  test "fixture" do
    one = moments(:one)
    assert_kind_of(Moment, one)
  end

end