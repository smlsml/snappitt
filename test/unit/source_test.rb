require 'test_helper'

class SourceTest < ActiveSupport::TestCase

  test "fixture" do
    assert_kind_of(Source, sources(:website))
  end

end
