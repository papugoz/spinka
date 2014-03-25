require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Spinka
  class Application < Rails::Application

   I18n.enforce_available_locales = true

   config.assets.paths << "#{Rails}/vendor/assets/fonts"

    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :pl
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
end
end
