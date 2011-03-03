require 'test_helper'

class MomentContactsTest < ActiveSupport::TestCase

  test "fixture" do
    one = moment_contacts(:one)
    assert_kind_of(MomentContact, one)
  end
end
