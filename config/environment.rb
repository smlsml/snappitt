# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Photo::Application.initialize!

require "hassle" #unless RAILS_ENV['development']