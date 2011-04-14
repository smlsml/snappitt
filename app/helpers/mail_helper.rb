module MailHelper

  class Cause::EmailDecorator < Cause::Decorator
    def initialize(controller, viewer = nil)
      @controller = controller
      super(viewer)
    end

    protected

    def subject
      anchor = @cause.subject.is_a?(Moment) ? {:anchor => @cause.subject.to_key} : {}
      experience = @cause.subject.is_a?(Experience) ? @cause.subject: nil
      experience = @cause.subject.experience if @cause.subject.respond_to?(:experience)
      link = experience.blank? ? '' : @controller.experience_url(experience, anchor)

      '%s %s' % [super, link]
    end

  end

end
