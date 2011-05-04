Photo::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  Paperclip.options[:command_path] = "/opt/local/bin/"

  config.site_assets_prefix = 'http://snappitt-assets.s3.amazonaws.com'
end

ENV['PANDASTREAM_URL'] = 'http://b49280ee59fc206caf3f:42d8516f159fc45cb9fa@api.pandastream.com:80/c2604c067706fb61964a41b3dca915b4'
