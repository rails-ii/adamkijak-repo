ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

class ActiveSupport::TestCase
  setup do
    Capybara.reset_sessions!
  end
end

class ActionController::IntegrationTest
  include Capybara
end
