class LikeFlag < MomentFlag

  belongs_to :user, :inverse_of => :likes, :counter_cache => :likes_count
  belongs_to :moment, :inverse_of => :likes, :counter_cache => :likes_count

  class CreateCause < Cause
    include Cause::HasNotifications
    def verb; 'liked'; end
  end

  after_create :create_cause

  protected

  def create_cause
    CreateCause.create!(:user => user, :action => self, :subject => moment)
  end

end