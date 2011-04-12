require 'test_helper'

class ExperienceCollaboratorTest < ActiveSupport::TestCase

  def setup
    @ec = experience_collaborators(:snoop_group_dre)
  end

  test "fixture" do
    assert @ec.valid?
    assert_kind_of ExperienceCollaborator, @ec
  end

  test "user is unique per experience" do
    second = @ec.clone
    assert !second.valid?

    second.user = users(:snoop)

    assert second.valid?
  end

end
