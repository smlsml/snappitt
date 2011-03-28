require "RMagick"

class Asset < ActiveRecord::Base

  belongs_to :creator, :class_name => 'User', :foreign_key => 'user_id_creator'
  belongs_to :source

  if Rails.env == 'production'
    has_attached_file :data,
                      :styles => {:tiny => "24x24#",
                                  :thumb => "48x48#",
                                  :feed => "280x280^",
                                  :preview => ['300x300>', :jpg],
                                  :large => ['650x650>', :jpg]},
                      :convert_options => {:all => '-auto-orient', :feed => '-auto-orient -gravity center -extent 280x157'},
                      :storage => :s3,
                      :s3_credentials => "#{Rails.root}/config/s3.yml",
                      :path => ":id/:style_:extension",
                      :bucket => "snappitt0"
  else
    has_attached_file :data,
                      :styles => {:tiny => "24x24#",
                                  :thumb => "48x48#",
                                  :feed => "280x280^",
                                  :preview => ['300x300>', :jpg],
                                  :large => ['650x650>', :jpg]},
                      :convert_options => {:all => '-auto-orient', :feed => '-auto-orient -gravity center -extent 280x157'}
  end

  def geolocation
    geo = Geocode.where(:lat => lat, :lng => lng).order('created_at DESC').first
    return ('%s, %s' % [geo.city, geo.state]) if geo && geo.success
    '%s, %s' % [lat, lng]
  end

  after_data_post_process :post_process
  after_create :request_geocode

  def post_process
    imgfile = ::Magick::Image.read(data.queued_for_write[:original].path).first

    return unless imgfile

    exif = {}
    keys = {
      :lat => 'GPSLatitude',
      :latref => 'GPSLatitudeRef',
      :lng => 'GPSLongitude',
      :lngref => 'GPSLongitudeRef',
      :model => 'Model',
      :make => 'Make',
      :taken => 'DateTime'
    }

    keys.each do |k, v|
      result = imgfile.get_exif_by_entry(v)
      pair = result[0] if result
      exif[k] = pair[1].to_s if pair && pair.is_a?(Array) && !pair[1].blank?
    end

    #logger.info "Photo EXIF: " + imgfile.get_exif_by_entry().inspect

    if exif[:lat] && exif[:lng]
      self.lat = ddmmss_to_degree(exif[:lat], exif[:latref].to_s == 'S')
      self.lng = ddmmss_to_degree(exif[:lng], exif[:lngref].to_s == 'W')
    end

    self.taken_at = DateTime.strptime(exif[:taken], '%Y:%m:%d %H:%M:%S') if exif[:taken]
    self.device = exif[:model] if exif[:model]

    self.save unless self.new_record?
  end

  def self.default_url(type = :thumb)
    '/images/default/%s/unknown.%s' % [type.to_s, type == 'large' || type == 'preview' ? 'jpg' : 'png']
  end

  def ddmmss_to_degree(str, negative = false)
    sum = 0
    set = {:dd => 0, :mm => 0, :ss => 0}
    divby = {:dd => 1, :mm => 60, :ss => 3600}

    set[:dd], set[:mm], set[:ss] = str.to_s.split(',')

    set.each do |k, v|
      number, precision = v.to_s.split('/')
      sum += (number.to_f / precision.to_f) / divby[k].to_f
    end

    sum.to_f * (negative ? -1 : 1)
  end

  protected

  def request_geocode
    Geocode.create(:lat => self.lat, :lng => self.lng)
    Delayed::Job.enqueue(Geocode)
    true
  end

end