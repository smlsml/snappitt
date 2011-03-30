class PublishFlag < MomentFlag

  belongs_to :user
  belongs_to :moment, :inverse_of => :publishes

  class CreateCause < Cause
    include Cause::HasNotifications
    def verb; 'published'; end
  end

  after_create :create_cause

  protected

  def create_cause
    CreateCause.create!(:user => user, :action => self, :subject => moment)
  end

end
