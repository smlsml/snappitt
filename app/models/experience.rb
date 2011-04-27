class Experience < ActiveRecord::Base

  belongs_to :user, :counter_cache => true
  has_one :event, :inverse_of => :experience
  has_many :moments, :dependent => :destroy do
    def fifo
      order('id')
    end

    def filo
      order('created_at DESC')
    end
  end
  has_many :comments, :through => :moments, :readonly => true
  has_many :likes, :class_name => 'LikeFlag', :through => :moments, :readonly => true
  has_many :collaborators, :class_name => 'ExperienceCollaborator'

  belongs_to :cover, :class_name => 'Moment', :foreign_key => 'moment_id_cover'

  validates :user, :presence => true

  attr_accessor :newly_created
  after_create :set_new
  after_create :add_collaborator
  before_save :set_cover

  scope :user_feed, lambda { |user|
    includes(:user => :profile, :cover => :asset).
    where(:visibility.ne => 'private', :users => {:confirmed_at.ne => nil}).
    order('experiences.created_at DESC')
  }

  scope :by_user, lambda { |user|
    includes(:user => :profile, :cover => :asset).
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
    rtitle.blank? || rtitle == '@' ? 'Snaps on %s' % created_at.to_formatted_s(:mdy) : rtitle
  end

  def photo_url(type = :feed)
    m = cover
    m = Moment.new unless m
    m.photo_url(type)
  end

  def moments_status
    '%s %s' % [moments_count, "moment".for_count(moments_count)]
  end

  def notify_users
    moments.collect{|m| m.notify_users}.flatten.compact.uniq
  end

  def upload_email
    return ('%s@%s' % [self.event.hashtag, I18n.translate('app.host')]) if self.event
    'post%s@%s' % [self.id, I18n.translate('app.host')]
  end

  protected

  def set_cover
    self.cover = moments.first unless self.cover
    true
  end

  def set_new
    self.newly_created = true
  end

  def add_collaborator
    ExperienceCollaborator.create(:experience => self, :user => user)
  end

end