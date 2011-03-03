require 'test_helper'

class ProfileTest < ActiveSupport::TestCase

  def setup
    @snoop = profiles(:snoop)
  end

  test "fixture" do
    assert_kind_of(Profile, @snoop)
  end

  test "user association" do
    assert_kind_of(User, @snoop.user)
    assert @snoop === @snoop.user.profile
  end

end