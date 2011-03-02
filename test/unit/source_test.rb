require 'test_helper'

class SourceTest < ActiveSupport::TestCase

  test "fixture" do
    one = sources(:one)
    assert_kind_of(Source, one)
  end
end
