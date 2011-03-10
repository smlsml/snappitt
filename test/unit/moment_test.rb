require 'test_helper'

class MomentTest < ActiveSupport::TestCase

  test "fixture" do
    @eat = moments(:eat)
    assert_kind_of(Moment, @eat)
    assert_kind_of(Source, @eat.source)
    assert_kind_of(PhotoAsset, @eat.asset)
    assert_kind_of(Thing, @eat.thing)
    assert_kind_of(Location, @eat.location)
    assert_kind_of(Like, @eat.likes.first)

    assert @eat == @eat.likes.first.moment # inverse_of
  end

  test "like counter" do
    @eat = moments(:eat)
    Like.create!(:moment_id => @eat.id, :user_id => users(:snoop).id)

    @eat.reload

    assert @eat.likes_count > 0
  end

end