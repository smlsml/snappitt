class Asset < ActiveRecord::Base

  belongs_to :user
  belongs_to :source

  validates :user, :presence => true

  def geolocation
    geo = Geocode.where(:lat => lat, :lng => lng).order('created_at DESC').first
    return ('%s, %s' % [geo.city, geo.state]) if geo && geo.success
    '%s, %s' % [lat.to_f.round(4), lng.to_f.round(4)]
  end

end