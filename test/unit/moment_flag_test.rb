require 'test_helper'

class MomentFlagTest < ActiveSupport::TestCase

  test "fixture" do
    assert_kind_of(LikeFlag, moment_flags(:snoop_likes_eat))
  end

end
