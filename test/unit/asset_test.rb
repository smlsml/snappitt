require 'test_helper'

class AssetTest < ActiveSupport::TestCase

  test "fixture" do
    one = assets(:one)
    assert_kind_of(Asset, one)
  end
end
