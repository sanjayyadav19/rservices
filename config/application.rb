require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rservices
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.assets.paths << Rails.root.join("app", "assets", "fonts")

    unless Rails.env.test?
      config.before_configuration do
   		  env_file = File.join(Rails.root, 'config', 'local_env.yml')
    	  YAML.load(File.open(env_file))[Rails.env].each do |key, value|
      	  ENV[key.to_s] = value
    		end if File.exists?(env_file)
  		end
    end

    config.generators do |g|
      g.test_framework :rspec, fixture: true, views: false
      g.fixture_replacement :factory_girl
      g.factory_girl dir: 'spec/factories/'

    end

  end
end
