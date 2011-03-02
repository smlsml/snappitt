require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  test "fixture" do
    one = comments(:one)
    assert_kind_of(Comment, one)
  end
end
