class Notification < ActiveRecord::Base

  belongs_to :user
  belongs_to :cause

  validates :user, :presence => true
  validates :cause_id, :presence => true, :uniqueness => {:scope => :user_id}

  after_create :send_notifications

  scope :new_for_user, lambda { |user|
    where(:user => user, :seen => false)
  }

  protected

  def send_notifications
    NotificationMailer.notify(user, self).deliver
  end

end
