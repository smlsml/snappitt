require 'test_helper'

class ContactTest < ActiveSupport::TestCase

  test "fixture" do
    assert_kind_of(Contact, contacts(:snoop))
  end

end