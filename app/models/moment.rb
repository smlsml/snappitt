class Moment < ActiveRecord::Base

  belongs_to :creator, :class_name => "User", :foreign_key => 'user_id_creator'

  belongs_to :asset
  belongs_to :source
  belongs_to :thing
  belongs_to :location
  belongs_to :experience
  belongs_to :comment

end