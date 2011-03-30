class MomentComment < Comment

  belongs_to :moment, :inverse_of => :comments, :counter_cache => :comments_count

  #validates :moment, :presence => true

  class CreateCause < Cause
    include Cause::HasNotifications
    def verb; 'added a comment to'; end
  end

  after_create :create_cause

  protected

  def create_cause
    CreateCause.create!(:user => user , :action => self, :subject => moment)
  end

end