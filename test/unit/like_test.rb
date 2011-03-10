require 'test_helper'

class LikeTest < ActiveSupport::TestCase

  test "fixture" do
    assert_kind_of(Like, likes(:snoop_likes_eat))
  end

end
