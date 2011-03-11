class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_nav

  def css_name
    '%s_controller' % controller_name.singularize.gsub('-', '_')
  end

  def is_account_page?
    request.path.starts_with?('/accounts')
  end

  protected

  def set_nav
    @nav_location = self.class.name.to_s.gsub('Controller', '').gsub('::','_').downcase
  end

end
