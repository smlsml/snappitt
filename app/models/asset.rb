class Asset < ActiveRecord::Base

  belongs_to :creator, :class_name => 'User', :foreign_key => 'user_id_creator'
  belongs_to :source

  if Rails.env == 'production'
    has_attached_file :data,
                      :storage => :s3,
                      :s3_credentials => "#{Rails.root}/config/s3.yml",
                      :path => ":id/:style_:extension",
                      :bucket => lambda do |attachment|
                        i = attachment.instance.id % 3
                        "snappitt#{i}"
                      end
  else
    has_attached_file :data
  end

end