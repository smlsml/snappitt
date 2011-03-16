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

  after_data_post_process :post_process

  def post_process
    imgfile = ::Magick::Image.read(data.queued_for_write[:original].path).first

    return unless imgfile
    logger.error "Photo EXIF: " + imgfile.get_exif_by_entry().inspect

    #if logger.info?
    #  exifDate = imgfile.get_exif_by_entry('DateTime')[0][1]
    #end
  end

end