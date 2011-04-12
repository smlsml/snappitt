class LikeFlag < MomentFlag

  belongs_to :user, :inverse_of => :likes, :counter_cache => :likes_count
  belongs_to :moment, :inverse_of => :likes, :counter_cache => :likes_count

  class CreateCause < Cause
    include Cause::HasNotifications
    def verb; 'liked'; end
  end

  after_create :create_cause
  after_create :add_collaborator

  protected

  def create_cause
    CreateCause.create!(:user => user, :action => self, :subject => moment)
  end

  def add_collaborator
    ExperienceCollaborator.create(:experience => moment.experience, :user => user)
  end

end
