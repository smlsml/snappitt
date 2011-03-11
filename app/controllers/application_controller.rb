class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_nav

  protected

    def is_bot?
      request.user_agent.to_s.include?('bot')
    end

    def set_nav
      @nav_location = self.class.name.to_s.gsub('Controller', '').gsub('::','_').downcase
    end

    def previous_page
      request.referrer if request.referrer.to_s.gsub('http://','').gsub('http://','').starts_with?(request.env['HTTP_HOST'].to_s)
    end

end