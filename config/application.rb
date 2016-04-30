require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CrossoverServer
  class Application < Rails::Application
    config.react.addons = true
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    def secrets #:nodoc:
      @secrets ||= begin
        secrets = ActiveSupport::OrderedOptions.new
        yaml = config.paths["config/secrets"].first

        if File.exist?(yaml)
          require "erb"
          all_secrets = YAML.load(ERB.new(IO.read(yaml)).result) || {}
          env_secrets = all_secrets[Rails.env]
          secrets.merge!(env_secrets.symbolize_keys) if env_secrets
        end

        # Fallback to config.secret_key_base if secrets.secret_key_base isn't set
        secrets.secret_key_base ||= config.secret_key_base

        secrets
      end
    end

  end
end
