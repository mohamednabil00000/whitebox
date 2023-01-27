require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Whitebox
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.autoload_paths += %W[
      #{config.root}/lib/jwt
    ]

    config.autoload_paths += Dir[File.join(Rails.root, 'lib', 'core_ext', '*.rb')].each { |l| require l }
    config.autoload_paths += Dir[File.join(Rails.root, 'app', 'r_spec', 'mocks', '*.rb')].each { |l| require l }

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    config.eager_load_paths << Rails.root.join("lib/jwt")
  end
end
