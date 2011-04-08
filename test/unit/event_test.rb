require 'test_helper'

class EventTest < ActiveSupport::TestCase

  def setup
    @artopia = events(:artopia)
  end

  test "fixture" do
    assert_kind_of(Event, @artopia)
  end

  test "experience association" do
    exp = @artopia.experience
    assert_kind_of(Experience, exp)
    assert @artopia === exp.event
  end

  test "hashtag format" do
    assert @artopia.valid?
    @artopia.hashtag = 'dAAaj.aZfa_ol-de09+234' # 25 is max
    assert @artopia.valid?
    @artopia.hashtag += "~"
    assert !@artopia.valid?
  end

end