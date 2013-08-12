ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

RSpec.configure do |config|
  #config.infer_base_class_for_anonymous_controllers = false
  config.use_transactional_fixtures = true

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.global_fixtures = :all     # Apply ALL fixtures

  config.order = "random"
  config.color_enabled = true       # Use color in STDOUT
  config.tty = true                 # Use color not only in STDOUT but also in pagers and files
  config.formatter = :documentation # Use the specified formatter (:progress, :html, :textmate)
end
