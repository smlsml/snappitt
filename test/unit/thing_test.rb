require 'test_helper'

class ThingTest < ActiveSupport::TestCase

  test "fixture" do
    assert_kind_of(Thing, things(:burger))
  end

end
