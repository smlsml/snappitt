require 'test_helper'

class PhotoAssetTest < ActiveSupport::TestCase

  test "fixture" do
    assert_kind_of(PhotoAsset, assets(:photo))
  end

end