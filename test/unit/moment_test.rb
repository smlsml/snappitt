require 'test_helper'

class MomentTest < ActiveSupport::TestCase

  def setup
    @eat = moments(:eat)
  end

  test "fixture" do
    assert_kind_of(Moment, @eat)
  end

  test "source association" do
    assert_kind_of(Source, @eat.source)
  end

  test "photo association" do
    assert_kind_of(PhotoAsset, @eat.asset)
  end

  test "thing association" do
    assert_kind_of(Thing, @eat.thing)
  end

  test "location association" do
    assert_kind_of(Location, @eat.location)
  end

end