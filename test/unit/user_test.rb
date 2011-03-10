require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "fixture" do
    @snoop = users(:snoop)
    assert_kind_of(User, @snoop)
    assert_kind_of(Profile, @snoop.profile)
    assert_kind_of(Contact, @snoop.contact)
  end

  test "like counter" do
    @snoop = users(:snoop)
    Like.create!(:moment_id => moments(:eat).id, :user_id => @snoop.id)

    @snoop.reload

    assert @snoop.likes_count > 0
  end

end