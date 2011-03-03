require 'test_helper'

class ServiceTest < ActiveSupport::TestCase

  test "fixture" do
    obj = services(:facebook)
    assert_kind_of(Service, obj)
    assert obj.is_a?(Service)
  end

end