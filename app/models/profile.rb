class Profile < ActiveRecord::Base

  has_one :user, :inverse_of => :profile

  belongs_to :hometown, :class_name => 'Location', :foreign_key => 'location_id_hometown'
  belongs_to :current_location, :class_name => 'Location', :foreign_key => 'location_id_current'

  belongs_to :photo_asset

  accepts_nested_attributes_for :hometown, :current_location

  def photo_url
    url = photo_asset.data.url(:thumb) if photo_asset
    url || '/images/unknown.png'
  end

end