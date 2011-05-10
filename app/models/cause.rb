class Cause < ActiveRecord::Base

  validates :user, :presence => true
  validates :action, :presence => true
  validates :subject, :presence => true

  belongs_to :user
  belongs_to :action, :polymorphic => true
  belongs_to :subject, :polymorphic => true

  def verb
    'caused'
  end

  def owner(viewer = nil)
    owner_user = self.subject.user if self.subject.respond_to?(:user)
    owner_user = self.subject if self.subject.is_a?(User)

    if owner_user.blank?
      ''
    elsif owner_user == self.user
      '%s own' % owner_user.profile.his_her
    elsif owner_user == viewer
      'your'
    else
      owner_user.to_s.possessive
    end
  end

  def title
    verb.capitalize
  end

  def summary(decorator = nil)
    decorator = Decorator.new(nil) unless decorator
    decorator.decorate(self)
  end

  def template
    '{user} {verb} {owner} {subject}'
  end

  scope :for_experience, lambda { |experience|
    includes(:user, :subject, :action).
    where({:subject_id => experience.moment_ids, :subject_type => 'Moment'} | {:subject_id => experience.id, :subject_type => 'Experience'}).
    order('created_at DESC')
  }

  scope :for_user, lambda { |user|
    includes(:user, :subject, :action).
    where({:user => user} & {:created_at.gt => 1.weeks.ago}).
    order('created_at DESC').
    limit(10)
  }

  def self.reject_deleted(results)
    results.reject{|u| u.subject.blank? || u.action.blank?}
  end

  class Decorator
    def initialize(viewer = nil)
      @viewer = viewer
    end

    def decorate(cause)
      @cause = cause

      out = cause.template || ''
      out.gsub!("{user}", user)
      out.gsub!("{verb}", verb)
      out.gsub!("{owner}", owner)
      out.gsub!("{subject}", subject)
      out
    end

    protected

    def user
      @cause.user.to_s
    end

    def verb
      @cause.verb
    end

    def owner
       @cause.owner(@viewer)
    end

    def subject
      return '%s as %s' % [@cause.subject.class.name, @cause.action.shot] if @cause.action.kind_of?(LikeFlag)
      @cause.subject.class.name
    end
  end

  module HasNotifications
    def self.included(base)
      base.after_create :create_notifications
    end

    protected

    def create_notifications
      create_notifications_for_users(subject.notify_users) if subject.respond_to?(:notify_users)
    end
  end

  protected

  def create_notifications_for_users(users)
    notifications = []
    users.delete_if{|u| u.id == self.user.id}.compact.uniq.each{ |u| notifications << {:user_id => u.id, :cause_id => self.id} }
    Notification.create!(notifications)
  end

end