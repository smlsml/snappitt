require 'test_helper'

class ExperienceTest < ActiveSupport::TestCase

  test "fixture" do
    @group = experiences(:group)
    assert_kind_of(Experience, @group)
    assert_kind_of(LikeFlag, @group.likes.first)
    assert_kind_of(Comment, @group.comments.first)
  end

  test "cover is set" do
    @exp = experiences(:private)
    assert_nil @exp.cover

    @moment = Moment.create!(:user => users(:snoop), :experience => @exp)
    @exp.moments << @moment
    assert_nil @exp.cover

    @exp.save!
    assert_equal @moment, @exp.reload.cover

    @exp.moments = [Moment.create!(:user => users(:snoop), :experience => @exp), @moment]
    @exp.save!

    assert_equal @moment, @exp.reload.cover
  end

end