require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'open-uri'

Bundler.require(:default, Rails.env)

module RecipeOMatic
  class Application < Rails::Application
    config.i18n.default_locale = :es
  end
end

require 'inflections/es'
