require 'test_helper'

class ConnectionTest < ActiveSupport::TestCase

  def setup
    @follow = connections(:snoop_dre)
  end

  test "fixture" do
    assert_kind_of(Connection, @follow)
    assert_kind_of(User, @follow.to)
    assert_kind_of(User, @follow.from)
  end

end