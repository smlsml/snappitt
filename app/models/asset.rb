class Asset < ActiveRecord::Base

  belongs_to :creator, :class_name => 'User', :foreign_key => 'user_id_creator'
  belongs_to :source

  if Rails.env == 'production'
    has_attached_file :data,
                      :styles => {:tiny => "24x24#",
                                  :thumb => "48x48#",
                                  :feed => "280x157#",
                                  :preview => '300x300>'},
                      :convert_options => {:feed => '-gravity center -extent 280x157' },
                      :storage => :s3,
                      :s3_credentials => "#{Rails.root}/config/s3.yml",
                      :path => ":id/:style_:extension",
                      :bucket => "snappitt0"
  else
    has_attached_file :data,
                      :styles => {:tiny => "24x24#",
                                  :thumb => "48x48#",
                                  :feed => "280x157#",
                                  :preview => '300x300>'},
                      :convert_options => {:feed => '-gravity center -extent 280x157' }
  end

end