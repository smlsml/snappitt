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

  def owner
    person = if subject.user.blank?
      ''
    elsif subject.user == user
      '%s own ' % subject.user.profile.his_her
    else
      '%s ' % subject.user.to_s.possessive
    end

    '%s%s' % [person, subject.class.name]
  end

  def summary
    "%s %s %s" % [user, verb, owner]
  end

  scope :for_experience, lambda { |experience|
    where({:subject_id => experience.moment_ids, :subject_type => 'Moment'} | {:subject_id => experience.id, :subject_type => 'Experience'}).
    order('created_at DESC')
  }

  scope :for_user, lambda { |user|
    where(:user => user).
    order('created_at DESC')
  }

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