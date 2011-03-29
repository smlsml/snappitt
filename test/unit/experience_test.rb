require 'test_helper'

class ExperienceTest < ActiveSupport::TestCase

  test "fixture" do
    @group = experiences(:group)
    assert_kind_of(Experience, @group)
    assert_kind_of(LikeFlag, @group.likes.first)
    assert_kind_of(Comment, @group.comments.first)
  end

end