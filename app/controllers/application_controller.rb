class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_nav
  before_filter :force_reset

  protected

    def force_reset
      if user_signed_in? && current_user.force_reset? && !is_account_page?
        flash[:notice] = "You must set a password"
        redirect_to user_settings_path(current_user)
      end
    end

    def is_bot?
      request.user_agent.to_s.include?('bot')
    end

    def set_nav
      @nav_location = self.class.name.to_s.gsub('Controller', '').gsub('::','_').downcase
    end

    def previous_page
      request.referrer if request.referrer.to_s.gsub('http://','').gsub('http://','').starts_with?(request.env['HTTP_HOST'].to_s)
    end

    def is_account_page?
      request.path.starts_with?('/accounts')
    end

    def can_edit?(user)
      user_signed_in? && ((user && user == current_user) || current_user.is_admin?)
    end

end