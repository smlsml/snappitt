class Like < ActiveRecord::Base

  belongs_to :user, :inverse_of => :likes, :counter_cache => true
  belongs_to :moment, :inverse_of => :likes, :counter_cache => true

  class CreateCause < Cause
    def verb; 'liked'; end
  end

  after_create :create_cause

  protected

  def create_cause
    CreateCause.create!(:user => user, :action => self, :subject => moment)
  end

end
