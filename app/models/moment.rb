class Moment < ActiveRecord::Base

  belongs_to :user
  belongs_to :asset, :dependent => :destroy
  belongs_to :source
  belongs_to :thing
  belongs_to :location
  belongs_to :experience, :counter_cache => true
  belongs_to :caption, :class_name => 'CaptionComment', :dependent => :destroy

  has_many :likes,
           :class_name => 'LikeFlag',
           :inverse_of => :moment,
           :dependent => :destroy do
    def by_user(user)
      where(:user_id => user.is_a?(User) ? user.id : 0)
    end
  end
  has_many :publishes, :class_name => 'PublishFlag', :inverse_of => :moment, :dependent => :destroy
  has_many :comments, :class_name => 'MomentComment', :inverse_of => :moment, :dependent => :destroy

  accepts_nested_attributes_for :caption

  #--

  validates :user, :presence => true

  #--

  def photo_url(type = :thumb)
    url = asset.data.url(type) if asset
    url || PhotoAsset.default_url(type)
  end

  def title
    '%s @ %s' % [thing, location]
  end

  def to_s
    title
  end

  def published?
    publishes.count > 0
  end

  def notify_users
    ([self.user, self.experience.user] + comments.collect{|c| c.user} + likes.collect{|l| l.user}).compact.uniq
  end

  def time
    self.created_at.getlocal.to_formatted_s(:timem).downcase
  end

  def grouped_flags
    grp = {}
    self.likes.each do |l|
      grp[l.shot] = [] unless grp[l.shot]
      grp[l.shot] << l.user
    end
    grp
  end

  #--

  def self.experience_id_for(moment_id)
    Moment.find(moment_id, :select => 'experience_id').experience_id
  end

  def self.increment_counter(field, id)
    super(field, id)
    Experience.increment_counter(field, Moment.experience_id_for(id))
  end

  def self.decrement_counter(field, id)
    super(field, id)
    Experience.decrement_counter(field, Moment.experience_id_for(id))
  end

  #--

  class CreateCause < Cause
    include Cause::HasNotifications
    def verb; 'added to'; end
  end

  after_create :create_cause
  after_create :add_collaborator

  protected

  def create_cause
    CreateCause.create!(:user => user, :action => self, :subject => experience)
  end

  def add_collaborator
    ExperienceCollaborator.create(:experience => experience, :user => user)
  end

end