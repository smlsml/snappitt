require 'test_helper'

class ServiceTest < ActiveSupport::TestCase

  test "fixture" do
    one = services(:one)
    assert_kind_of(Service, one)
    assert_equal Service, one.type
  end

end
