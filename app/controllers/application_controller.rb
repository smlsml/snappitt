class ApplicationController < ActionController::Base
  protect_from_forgery

  def css_name
    '%s_controller' % controller_name.singularize.gsub('-', '_')
  end

  def is_account_page?
    request.path.starts_with?('/accounts')
  end

end
