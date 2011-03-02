require 'test_helper'

class MomentTest < ActiveSupport::TestCase

  test "fixture" do
    one = moments(:one)
    assert_kind_of(Moment, one)
  end

  test "has_one source" do
    assert_kind_of(Source, moments(:one).source)
  end

  test "has_one photo" do
    assert_kind_of(PhotoAsset, moments(:one).asset)
  end

end