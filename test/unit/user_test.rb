require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "fixture" do
    @snoop = users(:snoop)
    assert_kind_of(User, @snoop)
    assert_kind_of(Profile, @snoop.profile)
    assert_kind_of(Contact, @snoop.contact)
  end

  test "likes_count: cached count of likes" do
    @snoop = users(:snoop)
    cnt = @snoop.likes_count
    like = Like.create!(:moment_id => moments(:eat).id, :user_id => @snoop.id)

    @snoop.reload
    assert_equal cnt + 1, @snoop.likes_count

    like.destroy
    @snoop.reload
    assert_equal cnt, @snoop.likes_count
  end

  test "experiences_count: cached count of experiences" do
    @snoop = users(:snoop)
    cnt = @snoop.experiences_count
    exp = Experience.create!(:title => 'Some experience', :user_id_creator => @snoop.id)

    @snoop.reload
    assert_equal cnt + 1, @snoop.experiences_count

    exp.destroy
    @snoop.reload
    assert_equal cnt, @snoop.experiences_count
  end

end