require 'test_helper'

class ContactTest < ActiveSupport::TestCase

  def setup
    @contact = contacts(:snoop)
  end

  test "fixture" do
    assert_kind_of(Contact, @contact)
    assert_kind_of(User, @contact.user)
  end

end