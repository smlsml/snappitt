class Experience < ActiveRecord::Base

  has_one :event, :inverse_of => :experience
  belongs_to :creator, :class_name => 'User', :foreign_key => 'user_id_creator'

  has_many :moments
  has_many :comments, :through => :moments, :readonly => true

  scope :user_feed, lambda { |user|
    order('updated_at DESC')
  }

  scope :by_user, lambda { |user|
    where('user_id_creator = ?', user.id).
    order('updated_at DESC')
  }

  def photo_url
    m = moments.first
    a = m.asset if m
    m && a ? a.data.url(:feed) : 'none'
  end

end
