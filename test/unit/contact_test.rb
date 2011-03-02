require 'test_helper'

class ContactTest < ActiveSupport::TestCase

  test "fixture" do
    one = contacts(:one)
    assert_kind_of(Contact, one)
  end
end
