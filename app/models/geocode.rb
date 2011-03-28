class Geocode < ActiveRecord::Base

  validates :lat, :presence => true, :numericality => true, :uniqueness => {:scope => :lng}
  validates :lng, :presence => true, :numericality => true

  def self.perform
    lookup = Geocode.where(:lookup_at => nil).order('created_at ASC').limit(1).first
    return true unless lookup

    lookup.update_attribute(:lookup_at, Time.now) if lookup
    result = Geokit::Geocoders::GoogleGeocoder.reverse_geocode([lookup.lat.to_f,lookup.lng.to_f]) if lookup

    if result && result.success
      lookup.street = result.street_address
      lookup.city = result.city
      lookup.state = result.state
      lookup.zip = result.zip
      lookup.country = result.country
      lookup.success = result.success ? true : false
    end

    lookup.save
    true
  end

end
