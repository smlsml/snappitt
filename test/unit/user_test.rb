require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "fixture" do
    assert_kind_of(User, users(:snoop))
  end

  test "profile association" do
    assert_kind_of(Profile, users(:snoop).profile)
  end

  test "contact association" do
    assert_kind_of(Contact, users(:snoop).contact)
  end

end