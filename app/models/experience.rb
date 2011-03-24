class Experience < ActiveRecord::Base

  has_one :event, :inverse_of => :experience
  belongs_to :creator, :class_name => 'User', :foreign_key => 'user_id_creator', :counter_cache => true

  has_many :moments, :order => 'moments.id', :dependent => :destroy
  has_many :comments, :through => :moments, :readonly => true
  has_many :likes, :through => :moments, :readonly => true

  scope :user_feed, lambda { |user|
    includes(:creator => :profile, :moments => :asset).
    where(:visibility.ne => 'private', :users => {:confirmed_at.ne => nil}).
    order('experiences.created_at DESC')
  }

  scope :by_user, lambda { |user|
    includes(:creator => :profile, :moments => :asset).
    where("user_id_creator = ?", user.id).
    order('created_at DESC')
  }

  scope :recent_groups, lambda {
    where("visibility = 'group'").
    order('created_at DESC').
    limit(3)
  }

  scope :last_three, lambda {
    user_feed.limit(3)
  }

  def private?
    'private' == visibility
  end

  def to_s
    title
  end

  def photo_url
    m = moments.first
    m = Moment.new unless m
    m.photo_url(:feed)
  end

  def moments_status
    '%s moment%s' % [moments_count, 1 == moments_count ? '':'s']
  end

end