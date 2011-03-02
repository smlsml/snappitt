require 'test_helper'

class ConnectionTest < ActiveSupport::TestCase

  test "fixture" do
    one = connections(:one)
    assert_kind_of(Connection, one)
  end
end
