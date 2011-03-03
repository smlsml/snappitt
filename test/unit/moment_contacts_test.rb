require 'test_helper'

class MomentContactsTest < ActiveSupport::TestCase

  test "fixture" do
    assert_kind_of(MomentContact, moment_contacts(:eat_snoop))
  end

end