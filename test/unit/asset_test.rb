require 'test_helper'

class AssetTest < ActiveSupport::TestCase

  def setup
    @asset = assets(:photo)
  end

  test "fixture" do
    assert_kind_of(Asset, @asset)
    assert_kind_of(User, @asset.user)
    assert_kind_of(Source, @asset.source)
  end

end
