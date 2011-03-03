require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def setup
    @comment = comments(:snoop_says)
  end

  test "fixture" do
    assert_kind_of(Comment, @comment)
    assert_kind_of(User, @comment.creator)
  end

end
