require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  test "fixture" do
    @comment = comments(:snoop_caption)
    assert_kind_of(Comment, @comment)
    assert_kind_of(User, @comment.creator)
  end

end
