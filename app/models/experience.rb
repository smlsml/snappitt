class Experience < ActiveRecord::Base

  has_one :event, :inverse_of => :experience
  belongs_to :creator, :class_name => 'User', :foreign_key => 'user_id_creator'

  has_many :moments
  has_many :comments, :through => :moments, :readonly => true

  scope :user_feed, lambda { |user|
    order('updated_at DESC')
  }

end
