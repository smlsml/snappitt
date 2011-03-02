require 'test_helper'

class ExperienceTest < ActiveSupport::TestCase

  test "fixture" do
    one = experiences(:private)
    assert_kind_of(Experience, one)
  end

end
