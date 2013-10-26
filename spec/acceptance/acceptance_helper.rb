require 'spec_helper'
require 'steak'
require 'capybara/rails'
require 'capybara/dsl'
require 'capybara/webkit'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

Capybara.default_driver = :webkit
Capybara.default_wait_time = 5
