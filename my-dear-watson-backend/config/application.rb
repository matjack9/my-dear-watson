require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
# require "rails/test_unit/railtie"
require 'watson-api-client'
require 'twitter'
require 'json'
require 'excon'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MyDearWatson
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
  end
end

# config_files = ['secrets.yml']
#
#     config_files.each do |file_name|
#       file_path = File.join(Rails.root, 'config', file_name)
#       config_keys = HashWithIndifferentAccess.new(YAML::load(IO.read(file_path)))[Rails.env]
#       config_keys.each do |k,v|
#         ENV[k.upcase] ||= v
#       end
#     end
