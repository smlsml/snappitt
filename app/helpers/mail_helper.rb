module MailHelper

  class Cause::EmailDecorator < Cause::Decorator
    def initialize(controller, viewer = nil)
      @controller = controller
      super(viewer)
    end

    protected

    def subject
      moment = @cause.subject.respond_to?(:moment) ? @cause.subject.moment : nil
      moment = @cause.subject if @cause.subject.is_a?(Moment)
      anchor = moment.nil? ? {} : {:anchor => moment.id}
      '%s (%s)' % [@cause.subject.class.name, @controller.experience_url(@cause, anchor)]
    end

  end

end
