class Experience < ActiveRecord::Base

  belongs_to :user, :counter_cache => true
  has_one :event, :inverse_of => :experience
  has_many :moments, :order => 'moments.id', :dependent => :destroy
  has_many :comments, :through => :moments, :readonly => true
  has_many :likes, :class_name => 'LikeFlag', :through => :moments, :readonly => true

  validates :user, :presence => true

  attr_accessor :newly_created
  after_create :set_new

  scope :user_feed, lambda { |user|
    includes(:user => :profile, :moments => :asset).
    where(:visibility.ne => 'private', :users => {:confirmed_at.ne => nil}).
    order('experiences.created_at DESC, moments.id')
  }

  scope :by_user, lambda { |user|
    includes(:user => :profile, :moments => :asset).
    where("user_id = ?", user.id).
    order('created_at DESC')
  }

  scope :recent_groups, lambda {
    where("visibility = 'group'").
    order('created_at DESC').
    limit(3)
  }

  scope :last_three, lambda {
    user_feed(nil).limit(3)
  }

  def private?
    'private' == visibility
  end

  def to_s
    title
  end

  def title
    rtitle = read_attribute(:title).strip
    rtitle.blank? || rtitle == '@' ? created_at.to_formatted_s(:mdy) : rtitle
  end

  def photo_url(type = :feed)
    m = moments.first
    m = Moment.new unless m
    m.photo_url(type)
  end

  def moments_status
    '%s %s' % [moments_count, "moment".for_count(moments_count)]
  end

  def notify_users
    moments.collect{|m| m.notify_users}.flatten.compact.uniq
  end

  protected

  def set_new
    self.newly_created = true
  end

end