require_relative 'boot'
require_relative File.join('..','lib','middleware','proxy_sim.rb')

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Cfg
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
    config.assets.precompile << %r(glyphicons-halflings-regular.(?:eot|svg|ttf|woff)$)

    config.middleware.insert_after Rack::Runtime, Cfg::ProxySim
  end
end
