ENV['RAILS_ENV'] ||= 'test'
require 'simplecov'
SimpleCov.start

require_relative '../config/environment'
require 'rspec/rails'
require 'webmock/rspec'

RSpec.configure do |config|
  config.order = 'random'
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
