class PublishFlag < MomentFlag

  belongs_to :user
  belongs_to :moment, :inverse_of => :publishes

  class CreateCause < Cause
    include Cause::HasNotifications
    def verb; 'published'; end
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
