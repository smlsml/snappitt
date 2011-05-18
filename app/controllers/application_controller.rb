class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_nav
  before_filter :set_timezone
  before_filter :force_reset
  before_filter :downcase

  protected

    def must_be_owner
      head :unauthorized unless can_edit?(current_user)
    end

    def force_reset
      @force_reset = true if user_signed_in? && current_user.force_reset? && !is_account_page?
    end

    def is_bot?
      request.user_agent.to_s.include?('bot')
    end

    def downcase
      params[:user][:login].downcase! if params[:user] && params[:user][:login]
    end

    def set_nav
      @nav_location = self.class.name.to_s.gsub('Controller', '').gsub('::','_').downcase
    end

    def set_timezone
      tz = current_user.try(:profile).try(:timezone)
      Time.zone = tz if tz
    end

    def previous_page
      request.referrer if request.referrer.to_s.gsub('http://','').gsub('http://','').starts_with?(request.env['HTTP_HOST'].to_s)
    end

    def is_account_page?
      request.path.starts_with?('/accounts')
    end

    def can_edit?(user)
      user_signed_in? && ((user && user == current_user) || current_user.admin?)
    end

end