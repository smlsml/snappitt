require 'test_helper'

class MomentTest < ActiveSupport::TestCase

  def setup
    @eat = moments(:eat)
  end

  test "fixture" do
    assert_kind_of(Moment, @eat)
    assert_kind_of(Source, @eat.source)
    assert_kind_of(PhotoAsset, @eat.asset)
    assert_kind_of(Thing, @eat.thing)
    assert_kind_of(Location, @eat.location)
    assert_kind_of(LikeFlag, @eat.likes.first)
    assert_kind_of(CaptionComment, @eat.caption)
    assert_kind_of(MomentComment, @eat.comments.first)

    assert @eat == @eat.likes.first.moment # inverse_of
  end

  test "like counter" do
    LikeFlag.create!(:moment_id => @eat.id, :user_id => users(:snoop).id)

    @eat.reload

    assert @eat.likes_count > 0
    assert @eat.experience.likes_count > 0
  end

  test "comment counter" do
    MomentComment.create!(:moment_id => @eat.id, :user_id => users(:snoop).id, :text => "whatever")

    @eat.reload

    assert @eat.comments_count > 0
    assert @eat.experience.comments_count > 0
  end

  test "create cause" do
    eat2 = @eat.clone
    eat2.save
    assert_equal eat2, Moment::CreateCause.where(:action_id => eat2.id, :action_type => 'Moment').first.action
  end

  test "publishing" do
    assert !@eat.published?
    PublishFlag.create!(:user => users(:snoop), :moment => @eat)
    @eat.reload
    assert @eat.published?
    assert_kind_of Cause, PublishFlag::CreateCause.first
  end

end