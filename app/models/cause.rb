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

  def summary
    "%s %s %s" % [user, verb, subject.creator.blank? ? '%s' % subject.class.name : '%s %s' % [subject.creator.to_s.possessive, subject.class.name]]
  end

  scope :for_experience, lambda { |experience|
    where({:subject_id => experience.moment_ids, :subject_type => 'Moment'} | {:subject_id => experience.id, :subject_type => 'Experience'}).
    order('created_at DESC')
  }

  scope :for_user, lambda { |user|
    where(:user => user).
    order('created_at DESC')
  }

end