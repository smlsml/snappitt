class Profile < ActiveRecord::Base

  has_one :user, :inverse_of => :profile

  belongs_to :hometown, :class_name => 'Location', :foreign_key => 'location_id_hometown'
  belongs_to :current_location, :class_name => 'Location', :foreign_key => 'location_id_current'

end