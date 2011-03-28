class Profile < ActiveRecord::Base

  has_one :user, :inverse_of => :profile

  belongs_to :hometown, :class_name => 'Location', :foreign_key => 'location_id_hometown'
  belongs_to :current_location, :class_name => 'Location', :foreign_key => 'location_id_current'

  belongs_to :photo_asset

  accepts_nested_attributes_for :hometown, :current_location

  def photo_url(type = :thumb)
    url = photo_asset.data.url(type) if photo_asset
    url || PhotoAsset.default_url(type)
  end

  def realname_unless
    realname unless user.username == realname
  end

end