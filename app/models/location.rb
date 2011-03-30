class Location < ActiveRecord::Base

  def to_s
    name
  end

  before_save :geolocate

  protected

  def geolocate
    result = Geokit::Geocoders::GoogleGeocoder.geocode(name.downcase) unless state

    if result && result.success
      self.address1 = result.street_address
      self.city = result.city
      self.state = result.state
      self.zip = result.zip
      self.lat = result.lat
      self.lng = result.lng
      self.precision = result.precision
      # suggested_bounds? Calc distance, save to meter_radius
    end

    true
  end

end
