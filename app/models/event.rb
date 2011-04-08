class Event < ActiveRecord::Base

  HASHTAG_REGEXP = /^[-A-Za-z0-9_.+]+$/

  belongs_to :experience, :inverse_of => :event

  before_create :downcase_hashtag

  validates :hashtag, :presence => true, :format => {:with => HASHTAG_REGEXP}, :length => {:minimum => 3, :maximum => 25}
  validates :name, :presence => true, :length => {:minimum => 3, :maximum => 255}
  validates :prize_at_moment, :presence => true, :numericality => true, :unless => :no_prize?

  def no_prize?
    prize.blank?
  end

  protected

  def downcase_hashtag
    self.hashtag.downcase!
    true
  end

end
