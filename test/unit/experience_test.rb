require 'test_helper'

class ExperienceTest < ActiveSupport::TestCase

  test "fixture" do
    assert_kind_of(Experience, experiences(:private))
  end

end