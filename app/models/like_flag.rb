class LikeFlag < MomentFlag

  SHOTS = ['Guys','Girls','Food/Drink','Funny','Weird','Artistic','Scenic','Blur','Inappropriate']

  belongs_to :user, :inverse_of => :likes, :counter_cache => :likes_count
  belongs_to :moment, :inverse_of => :likes, :counter_cache => :likes_count

  class CreateCause < Cause
    include Cause::HasNotifications
    def verb; 'tagged'; end
  end

  after_create :create_cause

  protected

  def create_cause
    CreateCause.create!(:user => user, :action => self, :subject => moment)
  end

end
